import 'package:flutter_test/flutter_test.dart';
import 'package:scorekar/features/match/domain/match_info.dart';

void main() {
  test('Team A wins toss with batting first', () {
    final info = MatchInfo(
      teamA: 'RCB',
      teamB: 'CSK',
      teamAPlayers: [],
      teamBPlayers: [],
      tossChoice: TossChoice.bats,
      tossWinner: 0,
    );
    expect(info.battingFirst, 0);
  });
  test('Team A wins toss with bowling first', () {
    final info = MatchInfo(
      teamA: 'RCB',
      teamB: 'CSK',
      teamAPlayers: [],
      teamBPlayers: [],
      tossChoice: TossChoice.bowl,
      tossWinner: 0,
    );
    expect(info.battingFirst, 1);
  });
  test('Team B wins toss with batting first', () {
    final info = MatchInfo(
      teamA: 'RCB',
      teamB: 'CSK',
      teamAPlayers: [],
      teamBPlayers: [],
      tossChoice: TossChoice.bats,
      tossWinner: 1,
    );
    expect(info.battingFirst, 1);
  });
  test('Team B wins toss with Bowling first', () {
    final info = MatchInfo(
      teamA: 'RCB',
      teamB: 'CSK',
      teamAPlayers: [],
      teamBPlayers: [],
      tossChoice: TossChoice.bowl,
      tossWinner: 1,
    );
    expect(info.battingFirst, 0);
  });
  
}
