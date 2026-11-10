import 'package:flutter_test/flutter_test.dart';
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/domain/cricket_match.dart';
import 'package:scorekar/features/match/domain/match_info.dart';
import 'package:scorekar/features/match/domain/match_state.dart';

void main() {
  test('Match test', () {
    final info = MatchInfo(
      teamA: 'tiger',
      teamB: 'Lion',
      teamAPlayers: [],
      teamBPlayers: [],
      overs: 5,
    );
    final inning1 = MatchState.fromBalls([Ball(run: 4), Ball(run: 6)]);
    final match = CricketMatch(info: info, innings1: inning1);

    expect(match.target, 11);
    expect(match.isFirstInning, true);
    expect(match.battingTeam, 0);
  });
  test('ball goes to second innings and first stays the same', () {
    final info = MatchInfo(
      teamA: 'tiger',
      teamB: 'Lion',
      teamAPlayers: [],
      teamBPlayers: [],
      overs: 5,
    );
    final inning1 = MatchState.fromBalls([Ball(run: 4)]);
    final inning2 = MatchState.fromBalls([]);
    final match = CricketMatch(
      info: info,
      innings1: inning1,
      innings2: inning2,
    );
    final updated = match.withBall(Ball(run: 6));
    expect(updated.innings1.totalRuns, 4);
    expect(updated.innings2!.totalRuns, 6);
  });
  test('undo removes ball from innings', () {
    final info = MatchInfo(
      teamA: 'tiger',
      teamB: 'Lion',
      teamAPlayers: [],
      teamBPlayers: [],
      overs: 5,
    );
    final inning1 = MatchState.fromBalls([Ball(run: 4), Ball(run: 1)]);
    final match = CricketMatch(info: info, innings1: inning1);
    final after = match.withUndo();
    expect(after.innings1.balls.length, 1);
  });
  test('undo removes with first inning', () {
    final info = MatchInfo(
      teamA: 'tiger',
      teamB: 'Lion',
      teamAPlayers: [],
      teamBPlayers: [],
      overs: 5,
    );
    final inning1 = MatchState.fromBalls([Ball(run: 4)]);
    final match = CricketMatch(info: info, innings1: inning1);
    final after = match.withUndo();
    expect(after.innings1.balls.length, 0);
  });
  test('undo removes with 2 inning without changing 1st inning', () {
    final info = MatchInfo(
      teamA: 'tiger',
      teamB: 'Lion',
      teamAPlayers: [],
      teamBPlayers: [],
      overs: 5,
    );
    final inning1 = MatchState.fromBalls([Ball(run: 4)]);
    final inning2 = MatchState.fromBalls([Ball(run: 2), Ball(run: 4)]);
    final match = CricketMatch(
      info: info,
      innings1: inning1,
      innings2: inning2,
    );
    final after = match.withUndo();
    expect(after.innings2!.balls.length, 1);
  });
  test('chase not completed', () {
    final info = MatchInfo(
      teamA: 'tiger',
      teamB: 'Lion',
      teamAPlayers: [],
      teamBPlayers: [],
      overs: 5,
    );
    final inning1 = MatchState.fromBalls(
      List.generate(30, (_) => Ball(run: 1)),
    );
    final inning2 = MatchState.fromBalls(
      List.generate(29, (_) => Ball(run: 1)),
    );
    final match = CricketMatch(
      info: info,
      innings1: inning1,
      innings2: inning2,
    );
    expect(match.isChaseCompleted, false);
  });
  test('chase  completed', () {
    final info = MatchInfo(
      teamA: 'tiger',
      teamB: 'Lion',
      teamAPlayers: [],
      teamBPlayers: [],
      overs: 5,
    );
    final inning1 = MatchState.fromBalls(
      List.generate(30, (_) => Ball(run: 1)),
    );
    final inning2 = MatchState.fromBalls(
      List.generate(30, (_) => Ball(run: 2)),
    );
    final match = CricketMatch(
      info: info,
      innings1: inning1,
      innings2: inning2,
    );
    expect(match.isInningOver, true);
  });
}
