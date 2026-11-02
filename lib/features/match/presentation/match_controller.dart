import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/domain/match_state.dart';

class MatchController extends Notifier<MatchState> {
  @override
  MatchState build() {
    return MatchState.fromBalls([]);
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
