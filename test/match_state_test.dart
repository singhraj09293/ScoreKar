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
  test('wicket counts', () {
    final ball = [Ball(run: 0), Ball(run: 1, type: BallType.wicket)];
    final state = MatchState.fromBalls(ball);
    expect(state.wickets, 1);
  });
  test('six normal balls = 1.0', () {
    final ball = [
      Ball(run: 0),
      Ball(run: 1),
      Ball(run: 2),
      Ball(run: 3),
      Ball(run: 1, type: BallType.wide),
    ];
    final state = MatchState.fromBalls(ball);
    expect(state.overs, '0.4');
  });
  test('striker swapping', () {
    // final ball = [Ball(run: 1)];
    // final ball = [Ball(run: 4)];
    // final ball = List.generate(6, (_) => Ball(run: 0));
    final balls = [Ball(run: 1), ...List.generate(5, (_) => Ball(run: 0))];
    final state = MatchState.fromBalls(balls);
    expect(state.strikerIndex, 0);
  });
  test('undo ball', () {
    final state = MatchState.fromBalls([
      Ball(run: 1),
      Ball(run: 4),
      Ball(run: 6),
    ]);
    expect(state.undo().totalRuns, 5);
  });
  test('inning over', () {
    final balls = List.generate(30, (_) => Ball(run: 0));
    final state = MatchState.fromBalls(balls);
    expect(state.isInningOver, true);
  });
}
