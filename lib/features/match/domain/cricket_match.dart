// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/domain/match_info.dart';
import 'package:scorekar/features/match/domain/match_state.dart';

class CricketMatch {
  const CricketMatch({
    required this.info,
    required this.innings1,
    this.innings2,
  });
  final MatchInfo info;
  final MatchState innings1;
  final MatchState? innings2;

  bool get isFirstInning => innings2 == null;
  int get target => innings1.totalRuns + 1;
  int get battingTeam =>
      isFirstInning ? info.battingFirst : 1 - info.battingFirst;
  MatchState get current => isFirstInning ? innings1 : innings2!;
  CricketMatch withBall(Ball ball) {
    if (isFirstInning) {
      final newInning = MatchState.fromBalls(
        [...innings1.balls, ball],
        maxOvers: innings1.maxOvers,
        maxWicket: innings1.maxWicket,
      );
      return CricketMatch(info: info, innings1: newInning);
    } else {
      final newInning2 = MatchState.fromBalls(
        [...innings2!.balls, ball],
        maxOvers: innings2!.maxOvers,
        maxWicket: innings2!.maxWicket,
      );
      return CricketMatch(info: info, innings1: innings1, innings2: newInning2);
    }
  }

  CricketMatch withUndo() {
    if (current.balls.isEmpty) return this;
    if (isFirstInning) {
      final newInning1 = MatchState.fromBalls(
        innings1.balls.sublist(0, innings1.balls.length - 1),
        maxOvers: innings1.maxOvers,
        maxWicket: innings1.maxWicket,
      );
      return CricketMatch(info: info, innings1: newInning1);
    } else {
      final newInning2 = MatchState.fromBalls(
        innings2!.balls.sublist(0, innings2!.balls.length - 1),
        maxOvers: innings2!.maxOvers,
        maxWicket: innings2!.maxWicket,
      );
      return CricketMatch(info: info, innings1: innings1, innings2: newInning2);
    }
  }

  CricketMatch startSecondInning() {
    final secondInning = MatchState.fromBalls(
      [],
      maxOvers: info.overs,
      maxWicket: info.battingFirst == 1
          ? info.teamBPlayers.length - 1
          : info.teamAPlayers.length - 1,
    );
    return CricketMatch(info: info, innings1: innings1, innings2: secondInning);
  }
}
