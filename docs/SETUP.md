# SETUP.md — macOS Development Environment

Complete install list for building **Journey**, a Strava-style drive recorder (Flutter, iOS + Android), with a self-hosted Valhalla map-matching server. Ordered so that each step's prerequisites are already satisfied.

Estimated time: 2–4 hours (most of it is downloads). Disk needed: ~40–60 GB free.

---

## 0. Prerequisites check

| Item | Requirement | Check |
|---|---|---|
| macOS | Recent version that runs the current Xcode (Apple only ships Xcode for the latest 1–2 macOS releases) | `sw_vers` |
| Disk | ≥ 40 GB free (Xcode ~15 GB, Android SDK/emulators ~15 GB, Flutter ~3 GB, Docker + Valhalla graph ~5 GB) | `df -h /` |
| RAM | 16 GB recommended (Docker + Android emulator + Xcode simultaneously is heavy on 8 GB) | About This Mac |
| Chip | Apple Silicon or Intel both work; note your arch for a few steps below | `uname -m` → `arm64` or `x86_64` |
| Accounts | Apple ID (free for device testing), Google account | — |

---

## 1. Core tooling

### 1.1 Xcode Command Line Tools + Homebrew
```bash
xcode-select --install          # git, clang, make
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Follow the post-install instructions Homebrew prints (adds `brew` to your shell PATH). Then:
```bash
brew install git wget jq
```

### 1.2 Shell setup
Zsh is default on macOS. All PATH exports below go in `~/.zshrc`. After editing: `source ~/.zshrc`.

---

## 2. Flutter SDK

Install via the official installer or Homebrew. Homebrew is easiest to keep updated:
```bash
brew install --cask flutter
```
Alternative (manual, more control over channel): download the stable SDK zip from https://docs.flutter.dev/get-started/install/macos, unzip to `~/development/flutter`, and add `export PATH="$HOME/development/flutter/bin:$PATH"` to `~/.zshrc`.

Verify:
```bash
flutter --version          # expect Flutter 3.4x stable, Dart 3.x
flutter doctor             # will show red X's for Xcode/Android until steps 3–4 are done
```

Disable analytics if you prefer: `flutter --disable-analytics`.

Dart comes bundled with Flutter; do NOT install Dart separately (it causes PATH conflicts).

---

## 3. iOS toolchain

### 3.1 Xcode
Install from the Mac App Store (search "Xcode") or https://developer.apple.com/xcode/. ~15 GB download; start this early and do other steps while it downloads.

After install:
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
sudo xcodebuild -license accept
```
Open Xcode once → Settings → Components → install the iOS Simulator runtime for the current iOS.

### 3.2 CocoaPods
Flutter now supports Swift Package Manager, but many plugins (including some map plugins) still ship as Pods, so install CocoaPods anyway:
```bash
brew install cocoapods
pod --version
```
If `pod install` fails later on Apple Silicon with ffi errors, use `arch -x86_64 pod install` or `sudo gem install ffi`.

### 3.3 Apple Developer account
- **Free Apple ID**: enough to run on your own iPhone (7-day provisioning, re-sign weekly). Sign in at Xcode → Settings → Accounts.
- **Apple Developer Program (US$99/yr)**: required for TestFlight, App Store, and for the `location` background mode entitlement to work reliably on-device across builds. Enroll at https://developer.apple.com/programs/ when you're ready to distribute; not needed on day one.

### 3.4 Verify
```bash
open -a Simulator
flutter doctor -v          # Xcode section should be green
```

---

## 4. Android toolchain

### 4.1 Android Studio
Download from https://developer.android.com/studio (pick the Apple Silicon build if `arm64`). Install, open, and let the setup wizard install the Android SDK, platform-tools and an emulator.

Then in Android Studio → Settings → Languages & Frameworks → Android SDK:
- **SDK Platforms**: install the latest stable API level (and API 34 for compatibility).
- **SDK Tools**: check *Android SDK Command-line Tools*, *Android SDK Build-Tools*, *Android Emulator*, *Android SDK Platform-Tools*.

Install the Flutter and Dart plugins: Settings → Plugins → search "Flutter" → Install (this pulls Dart automatically).

### 4.2 JDK 21
`maplibre_gl` requires JDK 21 for Android builds. Android Studio bundles a JBR (JetBrains Runtime), but a system JDK avoids Gradle confusion:
```bash
brew install --cask temurin@21
/usr/libexec/java_home -V                       # confirm 21 is listed
```
Add to `~/.zshrc`:
```bash
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
```
Tell Flutter which JDK to use: `flutter config --jdk-dir "$JAVA_HOME"`.

### 4.3 Accept licenses and verify
```bash
flutter doctor --android-licenses     # type y to all
adb version
flutter doctor -v                     # Android section green
```

### 4.4 Create an emulator (optional — GPS testing is poor on emulators)
Android Studio → Device Manager → Create Device → Pixel 8, latest system image with Google APIs (needed for FusedLocationProvider). Emulator GPS can be spoofed via *Extended Controls → Location → Routes*, useful for UI testing only.

### 4.5 Google Play Console (when ready to distribute)
US$25 one-time at https://play.google.com/console. Not needed for local development. Note: since 2023 new personal accounts must run a 14-day closed test with 12+ testers before production release — plan for it.

---

## 5. Physical devices (required for real GPS work)

**Android phone**
1. Settings → About phone → tap *Build number* 7 times → Developer options enabled.
2. Developer options → *USB debugging* ON.
3. Plug in, accept the RSA prompt, then `adb devices` should list it.
4. Wireless: `adb pair` / `adb connect` via Developer options → *Wireless debugging*.
5. If it's Xiaomi/Oppo/vivo/realme: also disable battery optimization for the app later, and read https://dontkillmyapp.com for your model. This is the single most common cause of "tracking stopped" bugs.

**iPhone**
1. Plug in, trust the computer.
2. Xcode → Window → Devices and Simulators → confirm it appears.
3. On the phone: Settings → Privacy & Security → Developer Mode → ON (iOS 16+), then restart.
4. First `flutter run` will fail on signing; open `ios/Runner.xcworkspace` in Xcode → Runner target → Signing & Capabilities → select your Team and confirm the Bundle Identifier is `com.rfoo1250.journey-app` (already set in the project; Android uses `com.rfoo1250.journey_app` because hyphens are illegal there). Subsequent runs work from the CLI.

Verify: `flutter devices` lists both phones.

---

## 6. Editor

**VS Code** (you already use it):
```bash
brew install --cask visual-studio-code
```
Extensions: *Flutter* (Dart-Code.flutter — pulls Dart), *Error Lens*, *GitLens*, *YAML*. Optional: *Flutter Riverpod Snippets*, *bloc*.

Or use Android Studio for everything; Flutter support there is first-class. Pick one and stick to it.

**Claude Code**:
```bash
npm install -g @anthropic-ai/claude-code   # requires Node 18+: brew install node
claude --version
```
Run `claude` inside the project folder; it will pick up `docs/PLAN.md` / `CLAUDE.md`.

---

## 7. Map-matching server (Valhalla in Docker)

### 7.1 Docker Desktop
Download from https://www.docker.com/products/docker-desktop/ (choose Apple Silicon or Intel). Or: `brew install --cask docker`. Launch once to finish setup. Give it ≥ 4 GB RAM in Settings → Resources.

### 7.2 Run Valhalla with Malaysia data
```bash
mkdir -p ~/dev/valhalla/custom_files && cd ~/dev/valhalla
wget -O custom_files/malaysia-singapore-brunei-latest.osm.pbf \
  https://download.geofabrik.de/asia/malaysia-singapore-brunei-latest.osm.pbf

docker run -dt --name valhalla -p 8002:8002 \
  -v $PWD/custom_files:/custom_files \
  -e serve_tiles=True -e server_threads=2 \
  ghcr.io/valhalla/valhalla-scripted:latest
```
First start builds the routing graph (~5–15 min for this extract). Watch progress: `docker logs -f valhalla`. It's ready when you see the server listening on 8002.

### 7.3 Test a match
```bash
curl -s http://localhost:8002/trace_route -d '{
  "shape":[{"lat":3.1390,"lon":101.6869},{"lat":3.1412,"lon":101.6905},{"lat":3.1450,"lon":101.6950}],
  "costing":"auto","shape_match":"map_snap",
  "trace_options":{"search_radius":50,"gps_accuracy":10}
}' | jq '.trip.legs[0].shape' | head -c 200
```
You should get an encoded polyline (precision 6). Also try `/trace_attributes` with the same body to see speed limits and road names per segment.

### 7.4 Reaching Valhalla from your phone during dev
Your phone can't see `localhost`. Options:
- Same Wi-Fi: use your Mac's LAN IP (`ipconfig getifaddr en0`) → `http://192.168.x.x:8002` in `.env`. Android release builds block cleartext HTTP; the debug manifest sets `android:usesCleartextTraffic="true"`. iOS blocks cleartext too; `Info.plist` sets `NSAppTransportSecurity → NSAllowsLocalNetworking`, which permits plain HTTP to local-network addresses only.
- Or tunnel: `brew install cloudflared` then `cloudflared tunnel --url http://localhost:8002` gives a public HTTPS URL. Preferred, since it works over mobile data while driving.

### 7.5 Later: deploy
A US$5–10/mo VPS (Hetzner, DigitalOcean) with 4 GB RAM runs this extract comfortably. Same `docker run`, add Caddy or Nginx for HTTPS.

---

## 8. Map tiles

Pick one and grab a key (all free-tier):
- **OpenFreeMap** — no key, no signup: `https://tiles.openfreemap.org/styles/liberty`. Start here.
- **MapTiler** — https://cloud.maptiler.com (100k tile requests/mo free).
- **Stadia Maps** — https://client.stadiamaps.com (200k credits/mo free, no card).

Keys go in a `.env` file loaded via `flutter_dotenv` or `--dart-define`; never commit them.

---

## 9. Python (optional, for offline prototyping)
You already know Python. Useful for analysing recorded traces before porting logic to Dart:
```bash
brew install python@3.12
python3 -m venv ~/dev/gps-lab && source ~/dev/gps-lab/bin/activate
pip install mappymatch osmnx geopandas folium
```

---

## 10. Create the project and smoke-test

The repo already lives at `~/Desktop/Journey` with `docs/PLAN.md`, `docs/SETUP.md` and `docs/COMMITS.md`. Scaffold the Flutter project *into* it (the `.` keeps the existing files):
```bash
cd ~/Desktop/Journey
flutter create --org com.rfoo1250 --project-name journey --platforms ios,android .   # Dart names can't contain '-'
flutter run -d <android-device-id>     # from `flutter devices`
flutter run -d <iphone-device-id>
```
This generates `com.rfoo1250.journey` on both platforms. The identifiers were then set to `com.rfoo1250.journey-app` (iOS) and `com.rfoo1250.journey_app` (Android) — hyphens are allowed in bundle IDs but not in Android application IDs. They do not need to match. Both devices should show the counter app before starting M0.

---

## 11. Final checklist

- [ ] `flutter doctor -v` shows no issues
- [ ] `flutter devices` lists your iPhone and Android phone
- [ ] Counter app runs on both physical devices
- [ ] `curl localhost:8002/status` returns Valhalla status JSON
- [ ] `/trace_route` returns a polyline for a KL test shape
- [ ] Tile style URL loads in a browser
- [ ] `claude` runs in the project folder
- [ ] `.env` created and in `.gitignore`

## Common problems

| Symptom | Fix |
|---|---|
| `CocoaPods not installed` in doctor | `brew install cocoapods`; restart terminal |
| Gradle "Unsupported class file major version" | JDK mismatch; confirm `flutter config --jdk-dir` points at 21 |
| iOS build "Signing for Runner requires a development team" | Open `ios/Runner.xcworkspace` in Xcode, set Team |
| Android build hangs downloading Gradle | First build is slow (~10 min); set `org.gradle.jvmargs=-Xmx4g` in `android/gradle.properties` |
| Valhalla container exits immediately | Check `docker logs valhalla`; usually a bad PBF path or Docker RAM too low |
| Phone can't reach Valhalla | Use LAN IP or cloudflared tunnel (see 7.4) |
| Location stops after a few minutes on Xiaomi | Battery saver → No restrictions for the app; Autostart ON |
