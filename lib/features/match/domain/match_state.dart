import 'ball.dart';

class MatchState {
  final List<Ball> balls;
  final int maxOvers;

  MatchState.fromBalls(this.balls, {this.maxOvers = 5});
  MatchState undo() {
    if (balls.isEmpty) return this;
    return MatchState.fromBalls(balls.sublist(0, balls.length - 1));
  }

  int get totalRuns => balls.fold(
    0,
    (sum, balls) =>
        sum +
        balls.run +
        (balls.type == BallType.wide ? 1 : 0) +
        (balls.type == BallType.noBall ? 1 : 0),
  );
  int get wickets => balls.where((ball) => ball.type == BallType.wicket).length;
  int get legalBalls => balls
      .where(
        (ball) => ball.type != BallType.noBall && ball.type != BallType.wide,
      )
      .length;
  String get overs => '${legalBalls ~/ 6}.${legalBalls % 6}';
  int get strikerIndex {
    int striker = 0;
    int legalCount = 0;
    for (final ball in balls) {
      if (ball.run % 2 != 0) {
        striker = 1 - striker;
      }
      if (ball.type != BallType.wide && ball.type != BallType.noBall) {
        legalCount = legalCount + 1;
        if (legalCount % 6 == 0) {
          striker = 1 - striker;
        }
      }
    }
    return striker;
  }

  bool get isInningOver => legalBalls >= maxOvers * 6;

  int runOf(int batter) {
    int striker = 0;
    List<int> runs = [0, 0];
    int legalCount = 0;

    for (final ball in balls) {
      runs[striker] += ball.run;
      if (ball.run % 2 == 1) {
        striker = 1 - striker;
      }
      if (ball.isLegal) {
        legalCount++;
        if (legalCount % 6 == 0) {
          striker = 1 - striker;
        }
      }
    }
    return runs[batter];
  }
}
