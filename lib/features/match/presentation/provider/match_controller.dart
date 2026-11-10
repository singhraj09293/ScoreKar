import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/domain/cricket_match.dart';
import 'package:scorekar/features/match/domain/match_info.dart';
import 'package:scorekar/features/match/domain/match_state.dart';

class MatchController extends Notifier<CricketMatch> {
  @override
  CricketMatch build() {
    return CricketMatch(
      info: ref.read(matchinfoProvider),
      innings1: MatchState.fromBalls([]),
    );
  }

  void startMatch() {
    final info = ref.read(matchinfoProvider);
    final batting = info.battingFirst == 0
        ? info.teamAPlayers
        : info.teamBPlayers;
    final limit = batting.length - 1;
    state = CricketMatch(
      info: info,
      innings1: MatchState.fromBalls(
        [],
        maxOvers: info.overs,
        maxWicket: limit,
      ),
    );
  }

  void addBall(Ball ball) {
    state = state.withBall(ball);
  }

  void undo() {
    state = state.withUndo();
  }
}

final matchProvider = NotifierProvider<MatchController, CricketMatch>(
  MatchController.new,
);

class MatchInfoController extends Notifier<MatchInfo> {
  @override
  MatchInfo build() {
    return MatchInfo(
      teamA: 'Team A',
      teamB: 'Team B',
      teamAPlayers: [],
      teamBPlayers: [],
    );
  }

  void setTeam(String a, String b, int over) {
    state = MatchInfo(
      teamA: a,
      teamB: b,
      teamAPlayers: [],
      teamBPlayers: [],
      overs: over,
    );
  }

  void setToss(int winner, TossChoice choice) {
    state = state.copyWith(tossWinner: winner, tossChoice: choice);
  }

  void setPlayer(List<String> teamAPlayer, List<String> teamBPlayer) {
    state = state.copyWith(
      teamAPlayers: teamAPlayer,
      teamBPlayers: teamBPlayer,
    );
  }
}

final matchinfoProvider = NotifierProvider<MatchInfoController, MatchInfo>(
  MatchInfoController.new,
);
