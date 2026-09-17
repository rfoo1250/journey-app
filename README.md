# Journey

Records car drives like Strava records runs. Flutter, iOS + Android.

- [docs/PLAN.md](docs/PLAN.md) — what we're building and how (source of truth)
- [docs/SETUP.md](docs/SETUP.md) — macOS dev environment, Valhalla server
- [docs/COMMITS.md](docs/COMMITS.md) — commit message convention

## Run
```bash
cp .env.example .env      # then edit VALHALLA_BASE_URL / MAP_STYLE_URL
dart run build_runner build
flutter run -d <device>
```

## Check before commit
```bash
tool/check.sh
```
