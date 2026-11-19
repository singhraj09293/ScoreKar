import 'package:scorekar/features/match/data/app_database.dart';
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/domain/match_info.dart';
import 'package:scorekar/features/match/domain/match_state.dart';

List<Ball> ballFromRows(List<BallRow> ball) {
  final balls = <Ball>[];
  for (int i = 0; i < ball.length; i++) {
    balls.add(
      Ball(run: ball[i].runs, type: BallType.values.byName(ball[i].type)),
    );
  }
  return balls;
}

MatchInfo infoFromRow(MatchRow row) {
  return MatchInfo(
    teamA: row.teamA,
    teamB: row.teamB,
    teamAPlayers: row.teamAPlayer.split(','),
    teamBPlayers: row.teamBPlayer.split(','),
    tossWinner: row.tossWinner,
    tossChoice: TossChoice.values.byName(row.tossChoice),
    overs: row.overs,
  );
}

MatchState stateFromRows(List<BallRow> row, int maxOver, int squadSize) {
  return MatchState.fromBalls(
    ballFromRows(row),
    maxOvers: maxOver,
    maxWicket: squadSize - 1,
  );
}
