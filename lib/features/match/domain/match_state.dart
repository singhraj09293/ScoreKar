import 'ball.dart';

class MatchState {
  final List<Ball> balls;
  final int maxOvers;
  final int maxWicket;

  MatchState.fromBalls(this.balls, {this.maxOvers = 5, this.maxWicket = 10});
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
    int nonStriker = 1;
    int next = 2;
    int legalCount = 0;
    for (final ball in balls) {
      if (ball.run % 2 != 0) {
        final temp = striker;
        striker = nonStriker;
        nonStriker = temp;
      }
      if (ball.type != BallType.wide && ball.type != BallType.noBall) {
        legalCount = legalCount + 1;
        if (legalCount % 6 == 0) {
          final temp = striker;
          striker = nonStriker;
          nonStriker = temp;
        }
      }
      if (ball.type == BallType.wicket) {
        striker = next;
        next++;
      }
    }
    return striker;
  }

  int get nonStrikerIndex {
    int striker = 0;
    int nonStriker = 1;
    int next = 2;
    int legalCount = 0;
    for (final ball in balls) {
      if (ball.run % 2 != 0) {
        final temp = striker;
        striker = nonStriker;
        nonStriker = temp;
      }
      if (ball.type != BallType.wide && ball.type != BallType.noBall) {
        legalCount = legalCount + 1;
        if (legalCount % 6 == 0) {
          final temp = striker;
          striker = nonStriker;
          nonStriker = temp;
        }
      }
      if (ball.type == BallType.wicket) {
        striker = next;
        next++;
      }
    }
    return nonStriker;
  }

  bool get isInningOver => legalBalls >= maxOvers * 6;

  bool get isAllOut => wickets >= maxWicket;

  int runOf(int batter) {
    int striker = 0;
    int nonStriker = 1;
    int next = 2;
    List<int> runs = List<int>.filled(11, 0);
    int legalCount = 0;

    for (final ball in balls) {
      runs[striker] += ball.run;
      if (ball.run % 2 == 1) {
        final temp = striker;
        striker = nonStriker;
        nonStriker = temp;
      }
      if (ball.isLegal) {
        legalCount++;
        if (legalCount % 6 == 0) {
          striker = nonStriker;
        }
      }
      if (ball.type == BallType.wicket) {
        striker = next;
        next++;
      }
    }
    return runs[batter];
  }

  int ballFacedBy(int batter) {
    int striker = 0;
    int nonStriker = 1;
    int next = 2;

    List<int> faced = List.filled(11, 0);
    int legalCount = 0;

    for (final ball in balls) {
      if (ball.type != BallType.wide) {
        faced[striker] += 1;
      }
      if (ball.run % 2 == 1) {
        final temp = striker;
        striker = nonStriker;
        nonStriker = temp;
      }
      if (ball.isLegal) {
        legalCount++;
        if (legalCount % 6 == 0) {
          final temp = striker;
          striker = nonStriker;
          nonStriker = temp;
        }
      }
      if (ball.type == BallType.wicket) {
        striker = next;
        next++;
      }
    }
    return faced[batter];
  }
}
