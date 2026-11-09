// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
