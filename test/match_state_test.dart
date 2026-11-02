import 'package:flutter_test/flutter_test.dart';
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/domain/match_state.dart';

void main() {
  test('three normal balls:1+4+0=5 runs', () {
    final ball = [Ball(run: 1), Ball(run: 4), Ball(run: 0)];
    final state = MatchState.fromBalls(ball);
    expect(state.totalRuns, 5);
  });
  test('Wide add 1 runs', () {
    final ball = [Ball(run: 0, type: BallType.wide)];
    final state = MatchState.fromBalls(ball);
    expect(state.totalRuns, 1);
  });
  test('no ball added 1 run and bawl again', () {
    final ball = [Ball(run: 4, type: BallType.noBall)];
    final state = MatchState.fromBalls(ball);
    expect(state.totalRuns, 5);
  });
}
