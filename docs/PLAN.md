# PLAN.md — Journey 

> This document is the source of truth for Claude Code. Read it fully before writing any code. When a decision here conflicts with something you'd normally do, follow this document and flag the conflict in your response. Update the **Progress** section at the bottom as milestones complete.

---

## 1. What we're building

A cross-platform mobile app (iOS + Android, Flutter) that records car drives the way Strava records runs. The user taps **Start**, drives, taps **Stop**. The app captures the GPS trace, snaps it to the road network, and saves a trip with start/end location, duration, distance and the route geometry. Each saved trip can be replayed as an animation of a small car driving along the recorded route on a map.

**Target user**: the developer (single-user, local-only for v1). No accounts, no server-side user data, no social features yet.

**Region focus for v1**: Malaysia (Klang Valley) — this determines the OSM extract loaded into the map-matching server and the test routes. Nothing in the code should be Malaysia-specific.

## 2. Goals and non-goals

### v1 goals (definition of done)
1. Start/Stop recording with a persistent foreground notification on Android and background location mode on iOS. Recording survives screen-off and app-backgrounding for at least 60 minutes of continuous driving.
2. Live map during recording: user's position, heading, and the trace drawn so far.
3. On Stop: trace is cleaned client-side, sent to Valhalla `trace_route`, and the matched polyline is stored. If Valhalla is unreachable, store the raw (cleaned) trace and mark the trip `unmatched` for later retry.
4. Trip list screen: newest first, showing date, start → end place names (reverse-geocoded, best-effort), distance, duration.
5. Trip detail screen: full route on map, stats card, and a **Replay** button that animates a car sprite along the route with correct heading, at adjustable speed (1×/4×/16×).
6. All data persists locally in SQLite. App is fully usable offline except map tiles and map matching.
7. Passes `flutter analyze` with zero warnings; unit tests cover the geo pipeline (filter → simplify → distance).

### Explicit non-goals for v1
- User accounts, cloud sync, sharing, leaderboards
- Auto-detection of drive start/stop (Activity Recognition) — v2
- Off-road / non-road tracking — v2+
- Turn-by-turn navigation
- Exporting video of the replay
- Web or desktop targets
- Any paid SDK (Transistorsoft etc.)

## 3. Tech stack (fixed — do not substitute without asking)

| Concern | Choice | Notes |
|---|---|---|
| Framework | Flutter (stable channel), Dart 3 | Null-safe, use records/patterns where they help |
| State management | `flutter_riverpod` (code-gen with `riverpod_generator`) | Providers per feature; no global singletons |
| Navigation | `go_router` | Typed routes |
| Models | `freezed` + `json_serializable` | Immutable, `copyWith`, JSON |
| Location | `geolocator` + `permission_handler` | Android: `ForegroundNotificationConfig` in `AndroidSettings` to get a foreground service. iOS: `UIBackgroundModes: location`, `allowBackgroundLocationUpdates` |
| Map | `maplibre_gl` | Vector tiles; style URL from env. **Not** `flutter_map`, **not** `google_maps_flutter` |
| Geo math | `turf` (Dart port) + `latlong2` | `along`, `bearing`, `length`, `simplify` |
| Polyline codec | `google_polyline_algorithm` | Valhalla uses precision **6** |
| HTTP | `dio` | Timeouts, retry interceptor for Valhalla |
| Local DB | `drift` (SQLite) | Reactive streams into UI |
| Animation | Flutter `AnimationController` + MapLibre symbol layer; `rive` for the car sprite (fallback: static PNG icon with `iconRotate`) | |
| Config | `flutter_dotenv` for tile key and Valhalla URL; `.env` in `.gitignore`, `.env.example` committed | |
| Logging | `logger` | No `print` in committed code |
| Tests | `flutter_test`, `mocktail` | |

Map matching runs **server-side** on a self-hosted Valhalla instance (Docker, see `docs/SETUP.md`). The app talks to it over HTTP; the base URL is configurable.

## 4. Architecture

Feature-first folder layout with a thin shared core. Each feature owns its data, domain and presentation layers.

```
lib/
  main.dart                     # bootstrap: dotenv, DB, ProviderScope, router
  app/
    router.dart
    theme.dart
  core/
    env.dart                    # typed access to .env
    db/
      database.dart             # drift DB, tables, migrations
      daos/
    geo/
      gps_filter.dart           # accuracy/speed sanity filter
      kalman.dart               # simple 2-D constant-velocity Kalman
      simplify.dart             # Douglas-Peucker wrapper (turf)
      distance.dart             # haversine along a LineString
      polyline6.dart            # encode/decode Valhalla polylines
    services/
      valhalla_client.dart      # trace_route / trace_attributes
      geocoder.dart             # reverse geocode start/end (Nominatim, rate-limited, best-effort)
    widgets/                    # shared UI atoms
  features/
    recording/
      data/location_repository.dart      # wraps geolocator stream, permissions
      domain/recording_state.dart        # freezed: idle | requesting | recording | paused | processing | error
      domain/recording_controller.dart   # riverpod Notifier — THE state machine
      presentation/record_screen.dart
      presentation/widgets/live_map.dart
    trips/
      data/trip_repository.dart          # drift DAO façade
      domain/trip.dart                   # freezed model
      domain/trip_processor.dart         # clean → match → stats → persist
      presentation/trip_list_screen.dart
      presentation/trip_detail_screen.dart
    replay/
      domain/replay_controller.dart      # AnimationController + turf.along/bearing
      presentation/replay_map.dart
      presentation/car_sprite.dart
test/
  core/geo/                     # unit tests for every file in core/geo
  features/recording/           # state machine tests with fake location stream
  fixtures/                     # real recorded traces as JSON (add as we drive)
```

### 4.1 Recording state machine

```
idle ──Start──▶ requestingPermission ──granted──▶ recording ──Stop──▶ processing ──▶ idle
                       │ denied                       │ Pause/Resume            │ error
                       ▼                              ▼                         ▼
                     error ◀──────────────────────  paused                   error (trip saved as unmatched)
```

- `recording`: subscribe to `Geolocator.getPositionStream` with `LocationAccuracy.bestForNavigation`, `distanceFilter: 5` m, Android foreground notification, iOS `activityType: automotiveNavigation`, `pauseLocationUpdatesAutomatically: false`.
- Every accepted fix is appended to an in-memory buffer **and** written to a `trip_points` table every ~10 s or 20 points (whichever first), so a crash loses ≤ 10 s of data. On app relaunch, if an `in_progress` trip exists, offer *Resume* or *Finish*.
- `processing` runs `TripProcessor.process(tripId)`; UI shows a spinner; must complete or fail within 30 s.

### 4.2 Geo pipeline (pure functions, fully unit-tested)

```
raw fixes
  → GpsFilter.apply        drop accuracy > 30 m, speed > 60 m/s, implausible jumps (>150 m in <1 s), duplicate timestamps
  → Kalman.smooth          light smoothing only; keep original timestamps
  → Simplify.rdp(ε=3 m)    reduce point count before HTTP
  → ValhallaClient.traceRoute(shape, costing: auto, shape_match: map_snap, search_radius: 50, gps_accuracy: median accuracy)
  → decode polyline6 → matched LineString
  → Distance.along(matched) → distance_m
  → stats: duration_s (last.ts − first.ts), avg_speed, max_speed (from raw fixes, filtered), moving_time (speed > 1 m/s)
  → persist Trip
```
If Valhalla fails: `distance_m` computed on the simplified raw trace, `match_status = unmatched`, retry on next app open or from trip detail.

### 4.3 Data model (drift)

**trips**
| column | type | notes |
|---|---|---|
| id | text PK (uuid v4) | |
| started_at / ended_at | int (epoch ms) | |
| status | text | `in_progress` \| `complete` |
| match_status | text | `matched` \| `unmatched` \| `failed` |
| distance_m | real | |
| duration_s / moving_s | int | |
| avg_speed_mps / max_speed_mps | real | |
| start_lat/lon, end_lat/lon | real | |
| start_place / end_place | text? | reverse-geocoded, nullable |
| raw_polyline6 | text | simplified raw trace |
| matched_polyline6 | text? | from Valhalla |
| created_at | int | |

**trip_points** (raw fixes, kept for reprocessing and future features)
| column | type |
|---|---|
| trip_id | text FK → trips.id (cascade delete) |
| ts | int |
| lat, lon | real |
| accuracy_m, speed_mps, heading_deg, altitude_m | real? |

Index on `(trip_id, ts)`.

### 4.4 Replay

- Input: matched (or raw) LineString, total length L.
- `AnimationController(duration: baseDuration / speedMultiplier)`; on each tick compute `d = t * L`, `pos = turf.along(line, d)`, `bearing = turf.bearing(along(d−2m), along(d+2m))`.
- Car rendered as a MapLibre `SymbolLayer` on a GeoJSON source with one point feature; update via `setGeoJsonSource`, `iconRotate` bound to bearing, `iconRotationAlignment: map`.
- Camera: follow mode (ease to car every 500 ms) toggleable; default fits whole route.
- Sprite: `assets/car.riv` if present, else `assets/car.png`. Keep the asset swap trivial.

### 4.5 Platform config checklist (do these in milestone 1)

**Android** (`android/app/src/main/AndroidManifest.xml`)
- `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`, `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_LOCATION`, `POST_NOTIFICATIONS`
- **Do not** add `ACCESS_BACKGROUND_LOCATION` in v1 — user-initiated foreground service is sufficient and avoids the stricter Play review.
- `minSdk 23`, `targetSdk` = latest stable, JDK 21, `usesCleartextTraffic` only in `debug/AndroidManifest.xml`.

**iOS** (`ios/Runner/Info.plist`)
- `NSLocationWhenInUseUsageDescription`, `NSLocationAlwaysAndWhenInUseUsageDescription` — write honest, specific strings ("Journey records your route while a drive is in progress. Location is stored only on this device.")
- `UIBackgroundModes: [location]`
- `NSMotionUsageDescription` (needed later for activity recognition; harmless now)

## 5. Milestones

Work strictly in order. Each milestone ends with: `flutter analyze` clean, tests green, a short note in **Progress**, and a git commit.

**M0 — Scaffold (½ day)**
Project structure above, dependencies, `.env.example`, riverpod + go_router + drift wired, empty screens navigable, CI-style script `tool/check.sh` (`flutter analyze && flutter test`).

**M1 — Location + permissions (1 day)**
`LocationRepository` exposing `Stream<Position>`; permission flow with graceful denial UI; Android foreground notification appears during recording; iOS background location verified with a 10-min screen-off test. Log fixes to console.

**M2 — Live map (1 day)**
`maplibre_gl` map with OpenFreeMap style; user puck; live `LineLayer` of the trace; camera follows heading. Start/Stop buttons drive the state machine; trip and points persisted.

**M3 — Geo pipeline + Valhalla (1–2 days)**
All `core/geo` functions with unit tests using fixture traces; `ValhallaClient` with timeout/retry; `TripProcessor`; trips show matched route and correct distance. Compare matched vs raw distance on 3 real drives and record the delta in **Progress**.

**M4 — Trip list + detail (1 day)**
List with reactive drift stream; detail with static route map and stats card; delete with confirm; reverse-geocoded place names (best-effort, cached).

**M5 — Replay animation (1–2 days)**
`ReplayController`, car symbol with rotation, speed selector, follow-cam toggle, scrub slider. Static PNG first, Rive if time permits.

**M6 — Hardening (1 day)**
Crash-resume of `in_progress` trip; unmatched-retry; battery test (1 h drive, note % drop); Xiaomi/Oppo battery-optimization guidance dialog; app icon; release build on both platforms installs and records.

## 6. Coding conventions

- Dart style: `dart format`, `very_good_analysis` lint set (or `flutter_lints` if it fights too much — ask).
- One widget per file over ~150 lines. Prefer composition over deep widget trees.
- Riverpod: `@riverpod` code-gen; controllers are `Notifier`s; repositories are plain classes provided via `Provider`. No `ref.read` in `build`.
- All geo math is pure and lives in `core/geo` — no Flutter imports there, so it's testable without a device.
- Units: metres, seconds, m/s internally. Format to km / km/h only in presentation.
- Time: store epoch ms UTC; display local.
- Errors: domain layer returns `Result<T, AppError>` (sealed class), never throws across feature boundaries. Log with `logger`, surface with a `SnackBar` via a shared `ErrorPresenter`.
- No `print`. No `TODO` without an owner and milestone tag, e.g. `// TODO(M5): rive sprite`.
- Secrets never in code. If you need a key, read `Env.x` and add the name to `.env.example`.
- Commit messages: conventional commits (`feat(recording): …`, `fix(geo): …`).

## 7. Testing strategy

- **Unit**: every function in `core/geo`, `TripProcessor` with a mocked `ValhallaClient`, `RecordingController` with a fake position stream (advance through all states, including denial and crash-resume).
- **Fixtures**: after each real drive, export the raw points as JSON into `test/fixtures/` (add a debug-only "Export raw" button in trip detail). These become regression tests for the pipeline.
- **Widget**: smoke tests that each screen builds with fake providers.
- **Manual device checklist** (kept in `docs/DEVICE_TESTS.md`): screen-off 10 min, app backgrounded 10 min, phone call mid-drive, airplane mode mid-drive (should still record, match later), low-battery mode.
- Map rendering is not unit-tested; verify on device.

## 8. Known risks and how we handle them

| Risk | Mitigation in v1 |
|---|---|
| Android OEM kills the foreground service (Xiaomi/Oppo/vivo) | Foreground service with notification; first-run dialog linking to battery settings; periodic DB flush so a kill loses ≤10 s |
| iOS suspends location when stationary at a long red light | `pauseLocationUpdatesAutomatically: false`; `activityType: automotiveNavigation` |
| Urban canyon / elevated highway GPS drift (KLCC, AKLEH) | Accuracy filter + Kalman + Valhalla map_snap with heading & timestamps in the shape payload |
| Valhalla unreachable while on mobile data | Store unmatched, retry later; Valhalla URL is env-configurable (tunnel or VPS) |
| Tile provider quota | OpenFreeMap has none; keep provider swappable via style URL |
| Battery drain | `distanceFilter: 5`, no map re-render per fix (throttle UI updates to 1 Hz) |
| Play Store location review | Foreground-only permission set; honest permission strings; privacy policy text in `docs/PRIVACY.md` |

## 9. Future roadmap (not for v1 — do not build, but keep the door open)

- Auto-start/stop via Activity Recognition (`in_vehicle`)
- Speed-limit compliance, toll segments, road-class split via Valhalla `trace_attributes`
- Elevation profile (Valhalla elevation service)
- Personal heatmap of all drives
- Replay video export (screen capture + ffmpeg)
- Offline tile packs (`maplibre_gl` offline regions)
- Cloud sync (Supabase + PostGIS), sharing
- Off-road mode: skip matching, terrain/hillshade tiles
- OBD-II Bluetooth telemetry

## 10. Working with Claude Code — instructions

- Before each milestone, restate in one paragraph what you'll build and which files you'll touch; wait for a go-ahead only if the plan deviates from this document.
- Prefer small, reviewable commits. Each commit should try to focus on one aspect/feature or housekeeping/documentation. Run `tool/check.sh` before every commit.
- When a package API differs from what this document assumes (versions move fast), read the package's current README/CHANGELOG on pub.dev, adapt, and note the change in **Progress**.
- Never add a dependency not listed in §3 without proposing it first with a one-line justification.
- When you need a real device to verify something (permissions, background behaviour, map rendering), stop and write a precise manual test script for the developer to run, then continue once results are reported.
- Keep this file updated: tick milestones, record measured numbers (battery %, matched-vs-raw distance deltas, point counts), and log decisions in the ADR list below.

## 11. Decision log (ADRs)

| # | Date | Decision | Why |
|---|---|---|---|
| 1 | 2026-09-15 | Flutter over React Native | Developer wants to learn a mobile-first stack; animation-heavy UI |
| 2 | 2026-09-15 | `maplibre_gl` over `flutter_map` | Vector tiles, GPU rendering, symbol rotation for car sprite |
| 3 | 2026-09-15 | Server-side map matching (Valhalla) over client-side | No mature Dart HMM matcher; Valhalla gives road attributes for free later |
| 4 | 2026-09-15 | No `ACCESS_BACKGROUND_LOCATION` in v1 | User-initiated foreground service suffices; avoids strict Play review |
| 5 | 2026-09-15 | Local-only storage, no backend | Single user; defers auth/privacy surface |
| 6 | 2026-09-17 | Domain `Trip` (freezed) separate from drift `TripRow` | Riverpod codegen can't see drift output in the same build phase; also keeps features drift-free |
| 7 | 2026-09-17 | Commit generated `*.g.dart` / `*.freezed.dart` | Clone-and-run works without a build step; `tool/check.sh` regenerates anyway |

## 12. Progress

- [x] M0 Scaffold — 2026-09-17
- [~] M1 Location + permissions — code complete 2026-09-17; device tests pending (docs/DEVICE_TESTS.md M1-A…E)
- [ ] M2 Live map
- [ ] M3 Geo pipeline + Valhalla
- [ ] M4 Trip list + detail
- [ ] M5 Replay animation
- [ ] M6 Hardening

### M0 notes (2026-09-17)
- Toolchain verified: Flutter 3.47.4 / Dart 3.13.3, Xcode 27.0, Android SDK 36 + build-tools 37, Temurin JDK 21, Valhalla 3.8.3 serving the Malaysia extract on :8002.
- iOS bundle ID `com.rfoo1250.journey-app`; Android applicationId `com.rfoo1250.journey_app` (hyphen illegal on Android). Kotlin namespace stays `com.rfoo1250.journey`.
- Package API changes vs. this doc (§10): `sqlite3_flutter_libs` is end-of-life and a no-op since `sqlite3` 3.x bundles SQLite via Dart hooks — not added. `build_runner` 2.16 removed `--delete-conflicting-outputs`. freezed 4 requires `abstract class`. very_good_analysis 11 enforces the new Dart shorthand constructor syntax (`const new({...})`, `const factory({...})`), applied via `dart fix`.
- `public_member_api_docs` lint disabled (internal app, not a package).
- Riverpod and drift generators run in the same build phase, so a `@riverpod` provider cannot reference a drift-generated row type. The freezed domain `Trip` model (§4 `features/trips/domain/trip.dart`) was therefore built in M0; drift rows are `TripRow`/`TripPointRow` and mapped in `TripRepository`.
- Typed routes are an `AppRoutes` helper class, not `go_router_builder` (not in §3). Propose adding it if route params grow.
- Widget tests must fake providers (§7) — a real drift stream inside flutter_test's fake-async zone leaves a pending timer and hangs `db.close()`. DB behaviour is covered by `test/core/db/database_test.dart` instead.
- Android build: `permission_handler` 14 requires `compileSdk = 37`, and Android 17 renamed platform packages to `android-37.0`/`37.2`. The template's AGP 9.1 cannot resolve that, so AGP → 9.4.0 and Gradle wrapper → 9.6.0. Debug APK and unsigned iOS build both verified.
- `tool/check.sh` runs build_runner → format → analyze (fatal infos) → test with a 60 s per-test timeout.
- Docs moved to `docs/` (PLAN, SETUP, COMMITS); README stays at root.

### M1 notes (2026-09-17)
- `minSdk = 24`, not 23 as §4.5 says: geolocator_android, permission_handler_android and the Flutter template all require 24. `targetSdk = 37` (latest stable, Android 17); drop to 36 if the device tests show foreground-service regressions.
- Android notification permission (`POST_NOTIFICATIONS`) is requested via permission_handler right after location is granted; without it the foreground-service notification is invisible on Android 13+.
- iOS: `showBackgroundLocationIndicator: true` so the user sees the blue pill while recording with the screen off. `pauseLocationUpdatesAutomatically = false` and `allowBackgroundLocationUpdates = true` are geolocator defaults, asserted in tests.
- `RecordingController` is `keepAlive` so navigating away from the Record screen never drops the subscription. Pause keeps the subscription (and the Android notification) alive and just ignores fixes.
- Testing gotchas recorded for later milestones: (1) a `StreamController.close()` future only completes once a listener gets `done` — never await it in tearDown; (2) in `testWidgets`, create stream controllers *inside* the fake-async zone (lazily in the stub) or their cancel futures never resolve under `pump()`.
- Device verification (foreground notification, 10-min iOS screen-off, denial flows) is scripted in `docs/DEVICE_TESTS.md`; results go in its table and here.
- 2026-09-17 iPhone 15 Pro: signed debug build installs and runs; location granted → fixes flow (±4 m indoors, ~1 per 10 s while stationary despite the 5 m filter — iOS emits periodic fixes); pause/resume/stop clean. iOS reports `heading = -1` when stationary — the geo filter (M3) must treat negative heading as unknown. Deny-forever → blocked screen → re-allow → recover verified. Backgrounding keeps the process alive (debug link drops on lock/background — use `flutter attach` to reconnect). Developer skipped the 10-min screen-off test; services-off screen and Android notification still to verify.

_Further notes and measurements go here as milestones complete._
