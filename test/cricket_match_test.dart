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
}
