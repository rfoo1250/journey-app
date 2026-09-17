#!/usr/bin/env bash
# CI-style gate: run before every commit (docs/PLAN.md §5, §10).
set -euo pipefail
cd "$(dirname "$0")/.."

[ -f .env ] || cp .env.example .env

dart run build_runner build
dart format --set-exit-if-changed lib test
flutter analyze --fatal-infos
flutter test --timeout 60s
echo "✓ check passed"
