import 'package:flutter_test/flutter_test.dart';
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/domain/match_state.dart';

void main() {
  test('three normal balls:1+4+0=5 runs', () {
    final ball = [
      Ball(run: 1), Ball(run: 4), Ball(run: 0)];
    final state = MatchState.fromBalls(ball);
    expect(state.totalRuns, 5);
  });
}
