import 'ball.dart';

class MatchState {
  final List<Ball> balls;

  MatchState.fromBalls(this.balls);

  int get totalRuns => balls.fold(0, (runs, sum)=>runs+sum.run);
}
