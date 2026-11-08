import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/domain/match_info.dart';
import 'package:scorekar/features/match/domain/match_state.dart';

class MatchController extends Notifier<MatchState> {
  @override
  MatchState build() {
    return MatchState.fromBalls([]);
  }

  void startMatch(int overs) {
    final info = ref.read(matchinfoProvider);
    final batting = info.battingFirst == 0
        ? info.teamAPlayers
        : info.teamAPlayers;
    final limit = batting.length - 1;
    state = MatchState.fromBalls([], maxOvers: overs, maxWicket: limit);
  }

  void addBall(Ball ball) {
    state = MatchState.fromBalls([...state.balls, ball]);
  }

  void undo() {
    state = state.undo();
  }
}

final matchProvider = NotifierProvider<MatchController, MatchState>(
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
