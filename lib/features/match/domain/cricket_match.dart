// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/domain/batters.dart';
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

  bool get isChaseCompleted => !isFirstInning && innings2!.totalRuns >= target;

  bool get isInningOver => current.isInningOver || isChaseCompleted;

  String? get result {
    final first = info.battingFirst == 0 ? info.teamA : info.teamB;
    final second = info.battingFirst == 0 ? info.teamB : info.teamA;
    if (!isInningOver || isFirstInning) return null;
    if (isChaseCompleted) {
      final results = innings2!.maxWicket - innings2!.wickets;
      return '$second won by $results wickets';
    } else if (innings1.totalRuns > innings2!.totalRuns) {
      final results = innings1.totalRuns - innings2!.totalRuns;
      return '$first won by $results runs';
    } else {
      return 'Match Tied';
    }
  }

  String? get winnerName {
    final first = info.battingFirst == 0 ? info.teamA : info.teamB;
    final second = info.battingFirst == 0 ? info.teamB : info.teamA;
    if (isFirstInning || !isInningOver) return null;
    if (isChaseCompleted) {
      return second;
    } else if (innings1.totalRuns > innings2!.totalRuns) {
      return first;
    } else {
      return null;
    }
  }

  Batters? get playerOfTheMatch {
    final first = info.battingFirst == 0
        ? info.teamAPlayers
        : info.teamBPlayers;
    final second = info.battingFirst == 0
        ? info.teamBPlayers
        : info.teamAPlayers;
    final a = innings1.statsFor(first);
    final b = innings2?.statsFor(second) ?? [];
    final all = [...a, ...b];
    if (all.isEmpty) return null;
    var best = all.first;
    for (final s in all) {
      if (s.runs > best.runs || s.runs == best.runs && s.balls < best.balls) {
        best = s;
      }
    }
    return best;
  }

  String? get marginText {
    if (!isInningOver || isFirstInning) return null;
    if (isChaseCompleted) {
      final results = innings2!.maxWicket - innings2!.wickets;
      return 'won by $results wickets';
    } else if (innings1.totalRuns > innings2!.totalRuns) {
      final results = innings1.totalRuns - innings2!.totalRuns;
      return 'won by $results runs';
    } else {
      return 'Match Tied';
    }
  }
}
