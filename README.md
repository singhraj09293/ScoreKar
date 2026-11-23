# Scorekar

**Fast, offline scoring for street and box cricket.**

Scorekar is a Flutter app built for gully cricket: set up a match in seconds, score every ball with big one-tap buttons, and finish with a shareable **Player of the Match** card. Everything runs on the phone, with no account and no internet needed.

<!-- Add a demo GIF here, e.g. ![Demo](docs/demo.gif) -->

## Screenshots

| New match | Live scoring | Result | Player of the Match |
|:---:|:---:|:---:|:---:|
| ![New match](docs/new_match.png) | ![Scoring](docs/scoring.png) | ![Result](docs/result.png) | ![POTM card](docs/potm.png) |

| History | Match detail |
|:---:|:---:|
| ![History](docs/history.png) | ![Detail](docs/detail.png) |

## Features

- **Quick match setup:** team names, overs (5 / 10 / 20 / custom), coin-flip toss, squads with drag-to-set batting order
- **One-tap scoring:** dot, 1, 2, 4, 6, wide, no-ball, wicket, with haptic feedback
- **Undo last ball** at any time, even after a wicket
- **Live scoreboard** with the last six balls, current batters and strike rotation
- **Two innings** with target, chase tracking and an automatic result ("won by 12 runs / 2 wickets", ties handled)
- **Player of the Match card** that you can share or save to the gallery
- **Match history** stored locally: browse past matches, open a full scorecard, delete a match
- **Scorecard per team:** runs, balls, 4s, 6s, "did not bat" list, total
- **Runs-per-over chart** with wicket markers
- **Fully offline:** all data lives in a local database on the device

## Cricket rules used

- **Wide:** +1 run, not a legal ball, no ball faced by the batter
- **No-ball:** +1 penalty run, not a legal ball, ball faced by the batter
- Strike changes on odd runs and at the end of every over (both can cancel out)
- Target = first innings runs + 1; the chase ends when the target is reached
- Wicket limit = batting squad size − 1
- Player of the Match = most runs across both innings, tie broken by fewer balls faced

## Tech stack

| Area | Choice |
|---|---|
| Framework | Flutter (Dart) |
| State management | Riverpod (`Notifier`, `FutureProvider`, `.family`) |
| Local database | Drift (SQLite) |
| Sharing / saving | `share_plus`, `saver_gallery` |
| Extras | `confetti`, `vibration`, `intl` |
| Tooling | `flutter_launcher_icons`, `flutter_native_splash` |
| Design | Google Stitch mockups, Inter font |

## Architecture

The logic is kept completely separate from the UI so it can be unit-tested without running the app.

```
lib/
  theme/                    # AppColors and theme
  features/match/
    domain/                 # Pure Dart: Ball, MatchState, MatchInfo, CricketMatch
    data/                   # Drift database, tables, mappers (row -> domain)
    presentation/
      provider/             # Riverpod providers
      screens/              # New match, toss, players, scoring, result, history, detail
```

**Key design idea: the list of balls is the single source of truth.**
Runs, wickets, overs, strike, batter stats and the over-by-over chart are all recalculated from that list by one `_replay()` loop. That makes **Undo** just "remove the last ball", and it means a saved match can be **rebuilt exactly** from its stored balls.

**Persistence:** a match is saved once, when the result screen appears: one row in `matches` (summary, squads, toss, overs) and one row per ball in `ball_rows`. Opening an old match rebuilds a full `CricketMatch` from those rows.

## Getting started

**Requirements:** Flutter SDK (stable channel) and an Android device or emulator.

```bash
git clone https://github.com/singhraj09293/scorekar.git
cd scorekar
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # generates the Drift code
flutter run
```

### Run the tests

```bash
flutter test
```

The scoring logic (balls, undo, strike, innings, target, result, Player of the Match, per-over stats) is covered by unit tests written test-first.

### Build a release APK

```bash
flutter build apk --release --split-per-abi
```

The APK is created in `build/app/outputs/flutter-apk/`. `app-arm64-v8a-release.apk` works on most modern phones.

## Roadmap

- Reopen a finished match to review the ball-by-ball timeline
- Bowling figures and fall of wickets
- "Not out" marker on the scorecard
- Cleaner result wording ("1 wicket", "1 run")
- Export a match as an image or PDF

## Credits

- **UI design:** mockups created in [Google Stitch](https://stitch.withgoogle.com)
- **Font:** [Inter](https://rsms.me/inter/) (SIL Open Font License)
- **Home screen photo:** Yogendra Singh on [Unsplash](https://unsplash.com)
- **Logo:** made by me

## Author

Built by **Raj**, a final-year BSc IT student and aspiring Flutter developer.

- GitHub: @<singhraj09293>(https://github.com/singhraj09293/scorekar.git)
- LinkedIn:  https://www.linkedin.com/in/raj-singh-928a79381

---

*Built for the gully, one ball at a time.* 🏏