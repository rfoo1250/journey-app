# Device tests

Manual checks that cannot run in `flutter test`. Run on both phones; record results in the table at the bottom and copy the row into `PLAN.md` → Progress.

Build and install a **debug** build first:
```bash
flutter devices
flutter run -d <id>            # first iOS run: set Team in Xcode (SETUP.md §5)
```
Watch fixes in the console: each accepted fix logs one `fix <ts> <lat>,<lon> ±<acc>m <speed>m/s hdg <deg>` line.

---

## M1 — Location + permissions

### M1-A Permission flow (both platforms)
1. Fresh install (or reset permissions: Android → App info → Permissions → Location → Ask every time; iOS → Settings → Journey → Location → Ask Next Time).
2. Open Journey → **Record** → **Start**.
3. Expect the OS permission prompt. Choose **Deny**.
   - ✅ Screen shows "Location permission needed" with **Try again** and **Dismiss**.
4. Tap **Try again**, this time **Allow while using**.
   - ✅ Status card appears: "Recording", timer counts, "Waiting for GPS…" then a position.
   - ✅ Console logs `fix …` lines.
5. Stop. Deny permanently (Android: deny twice / "Don't ask again"; iOS: Settings → Location → Never). Start again.
   - ✅ "Location is blocked" with **Open app settings** → lands on the app's settings page.
6. Turn device location services off entirely. Start.
   - ✅ "Location services are off" with **Open location settings**.

### M1-B Android foreground notification
1. Start recording. Swipe down the shade.
   - ✅ Ongoing notification "Journey is recording your drive" is present and cannot be swiped away.
2. Press Home, wait 2 min, reopen.
   - ✅ Fix count increased while backgrounded.
3. Pause → notification remains (service alive). Stop → notification disappears.

### M1-C iOS background location
1. Start recording. Lock the screen. Walk or drive for **10 minutes**.
2. Unlock, reopen.
   - ✅ Fix count kept increasing; timer shows ~10:00; blue location pill/arrow was shown while locked.
3. Repeat with the app swiped to the background (not killed) instead of screen-locked.

### M1-D Stationary robustness (both)
1. Start recording and sit still for 5 min (long red light simulation).
   - ✅ Recording state persists; no auto-pause; fixes may be few (5 m distance filter) but the timer runs.

### M1-E Phone call mid-recording (both)
1. Start recording, receive/make a 1-min call, hang up.
   - ✅ Still "Recording", fixes resume.

---

## M2 — Live map

### M2-A Map renders (both)
1. Record screen: map tiles (OpenFreeMap Liberty) visible under the controls.
2. Start → blue puck at your position within a few seconds; camera zooms to it.
3. Drag the map → follow switches off (button icon changes); tap the locate button → recenters.
4. Move ≥ 20 m → a blue line trails the puck.
5. Stop → trip appears in the list with date, distance, duration.

### M2-B Persistence
Pull the database and inspect (development builds only):
```bash
xcrun devicectl device copy from --device <udid> --domain-type appDataContainer \
  --domain-identifier com.rfoo1250.journey-app --source Documents/journey.sqlite --destination /tmp/journey.sqlite
sqlite3 /tmp/journey.sqlite 'select id,status,match_status,distance_m,duration_s from trips; select trip_id,count(*) from trip_points group by 1;'
```

## M3 — Geo pipeline + Valhalla

### M3-A Match on Stop (phone must reach Valhalla: SETUP.md §7.4)
1. Confirm from the phone's browser that `http://<mac-ip>:8002/status` returns JSON.
2. Record a real drive (≥ 2 km), Stop.
   - ✅ Console: `trip … matched: N → M pts, D m` within 30 s.
   - ✅ Trip list shows the distance; pull the DB (M2-B) and check `match_status = matched`, `matched_polyline6` non-null.
3. Record the **matched vs raw** delta: `distance_m` vs `Distance.along(raw_polyline6)` (or compare to the odometer). Do this for 3 drives and log them in PLAN.md → Progress → M3.

### M3-B Unmatched path
1. Turn off Wi-Fi on the phone (or stop the Valhalla container), record a short trip, Stop.
   - ✅ Console: `trip … not matched (MatchStatus.unmatched)`; list still shows raw distance.
2. Restore connectivity, kill and relaunch the app.
   - ✅ Console: the trip is re-processed and becomes `matched`.

## Results

| Date | Device / OS | Test | Result | Notes (fix rate, battery %, oddities) |
|---|---|---|---|---|
| 2026-09-17 | iPhone 15 Pro / iOS 26.7 | M1-A steps 2–4 (allow path), pause/resume/stop | ✅ | Allowed on first prompt; stationary indoors: 2 fixes in 20 s, ±4 m, speed 0, heading −1 (iOS reports −1 when stationary). Pause → Resume → Stop at ~2 s intervals, no errors, app stayed alive. Deny / deny-forever / services-off screens (steps 3, 5, 6) not yet exercised. |
| 2026-09-17 | iPhone 15 Pro / iOS 26.7 | M1-A step 5 (deny forever → recover) | ✅ | Settings → Location → Never, Start → console `Location permission denied forever`, blocked screen shown; re-allowed in Settings, Start → fixes resumed within seconds. |
| 2026-09-17 | iPhone 15 Pro / iOS 26.7 | M1-C step 3 (backgrounded, not killed) | ✅ (partial) | Recording started, app swiped to background: debug console link dropped but the process stayed alive for several minutes. Fix count after reopening not read. 10-min screen-off test skipped by developer. |
| — | iPhone | M1-A step 6 (services off), M1-D, M1-E | ⏭ | Not run yet. |
| — | Android | M1-B | ⏭ | Android phone not yet connected. |
| 2026-09-17 | iPhone 15 Pro / iOS 26.7 | M2-A steps 1–3, 5 | ✅ | Tiles load, puck at correct position, drag disables follow, recenter works. Step 4 (trace line) not yet observed — developer stationary. |
| 2026-09-17 | iPhone 15 Pro / iOS 26.7 | M2-B | ✅ | DB pulled: 1 trip `complete`/`unmatched`, 2 points, polyline stored. Found `duration_s = 0` → fixed (duration now last fix − first fix; iOS delivered a cached fix 5 s before Start). |
