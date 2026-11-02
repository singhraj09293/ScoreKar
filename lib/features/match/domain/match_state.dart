import 'ball.dart';

class MatchState {
  final List<Ball> balls;

  MatchState.fromBalls(this.balls);

  int get totalRuns => balls.fold(
    0,
    (sum, balls) =>
        sum +
        balls.run +
        (balls.type == BallType.wide ? 1 : 0) +
        (balls.type == BallType.noBall ? 1 : 0),
  );
  int get wickets => balls.where((ball) => ball.type == BallType.wicket).length;
}
