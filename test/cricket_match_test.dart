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
  test('Lion won by 2 wicket', () {
    final info = MatchInfo(
      teamA: 'Tigers',
      teamB: 'Lions',
      teamAPlayers: [],
      teamBPlayers: [],
      overs: 5,
      tossWinner: 0,
      tossChoice: TossChoice.bats,
    );
    final inning1 = MatchState.fromBalls(List.generate(5, (_) => Ball(run: 6)));
    final inning2 = MatchState.fromBalls([
      ...List.generate(5, (_) => Ball(run: 6)),
      Ball(run: 1),
      Ball(run: 0, type: BallType.wicket),
      Ball(run: 0, type: BallType.wicket),
    ], maxWicket: 4);
    final match = CricketMatch(
      info: info,
      innings1: inning1,
      innings2: inning2,
    );
    expect(match.result, 'Lions won by 2 wickets');
    expect(match.winnerName, 'Lions');
    expect(match.marginText, 'won by 2 wickets');
  });
  test('Tigers won by 10 runs', () {
    final info = MatchInfo(
      teamA: 'Tigers',
      teamB: 'Lions',
      teamAPlayers: [],
      teamBPlayers: [],
      overs: 5,
      tossWinner: 0,
      tossChoice: TossChoice.bats,
    );
    final inning1 = MatchState.fromBalls(List.generate(5, (_) => Ball(run: 6)));
    final inning2 = MatchState.fromBalls([
      ...List.generate(5, (_) => Ball(run: 4)),
      ...List.generate(25, (_) => Ball(run: 0)),
    ]);
    final match = CricketMatch(
      info: info,
      innings1: inning1,
      innings2: inning2,
    );
    expect(match.result, 'Tigers won by 10 runs');
    expect(match.winnerName, 'Tigers');
    expect(match.marginText, 'won by 10 runs');
  });
  test('Tied', () {
    final info = MatchInfo(
      teamA: 'Tigers',
      teamB: 'Lions',
      teamAPlayers: [],
      teamBPlayers: [],
      overs: 5,
      tossWinner: 0,
      tossChoice: TossChoice.bats,
    );
    final inning1 = MatchState.fromBalls(List.generate(5, (_) => Ball(run: 6)));
    final inning2 = MatchState.fromBalls([
      ...List.generate(5, (_) => Ball(run: 6)),
      ...List.generate(25, (_) => Ball(run: 0)),
    ]);
    final match = CricketMatch(
      info: info,
      innings1: inning1,
      innings2: inning2,
    );
    expect(match.result, 'Match Tied');
  });
  test('Highest scoring battsMan', () {
    final info = MatchInfo(
      teamA: 'Tigers',
      teamB: 'Lions',
      teamAPlayers: ['Ravi', 'Amit'],
      teamBPlayers: ['Sanjeet', 'Sainath'],
      overs: 5,
      tossWinner: 0,
      tossChoice: TossChoice.bats,
    );
    final inning1 = MatchState.fromBalls([
      Ball(run: 6),
      Ball(run: 6),
      Ball(run: 4),
      Ball(run: 1),
    ]);
    final inning2 = MatchState.fromBalls([
      ...List.generate(4, (_) => Ball(run: 2)),
      ...List.generate(26, (_) => Ball(run: 0)),
    ]);
    final match = CricketMatch(
      info: info,
      innings1: inning1,
      innings2: inning2,
    );
    final best = match.playerOfTheMatch;
    expect(best!.name, 'Ravi');
    expect(best.runs, 17);
  });
}
