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

## Results

| Date | Device / OS | Test | Result | Notes (fix rate, battery %, oddities) |
|---|---|---|---|---|
| | | | | |
