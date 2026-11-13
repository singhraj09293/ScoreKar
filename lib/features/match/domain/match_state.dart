import 'package:scorekar/features/match/domain/batters.dart';

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
    return _replay().striker;
  }

  int get nonStrikerIndex {
    return _replay().nonStriker;
  }

  bool get isInningOver => legalBalls >= maxOvers * 6 || isAllOut;

  int get ballInCurrentOver => legalBalls % 6;
  int get ballsRemainingInOver => 6 - ballInCurrentOver;

  bool get isAllOut => wickets >= maxWicket;

  int runOf(int batter) {
    return _replay().runs[batter];
  }

  int ballFacedBy(int batter) {
    return _replay().faced[batter];
  }

  ({
    int striker,
    int nonStriker,
    List<int> runs,
    List<int> faced,
    List<int> fours,
    List<int> sixs,
  })
  _replay() {
    int striker = 0;
    int nonStriker = 1;
    int next = 2;
    int legalCount = 0;
    final runs = List<int>.filled(11, 0);
    final faced = List<int>.filled(11, 0);
    final fours = List<int>.filled(11, 0);
    final sixs = List<int>.filled(11, 0);

    for (final ball in balls) {
      if (ball.run == 4) {
        fours[striker] += 1;
      }
      if (ball.run == 6) {
        sixs[striker] += 1;
      }
      runs[striker] += ball.run;
      if (ball.type != BallType.wide) {
        faced[striker] += 1;
      }
      if (ball.run % 2 == 1) {
        final temp = striker;
        striker = nonStriker;
        nonStriker = temp;
      }
      if (ball.type == BallType.wicket) {
        striker = next;
        next++;
      }
      if (ball.isLegal) {
        legalCount++;
        if (legalCount % 6 == 0) {
          final temp = striker;
          striker = nonStriker;
          nonStriker = temp;
        }
      }
    }
    return (
      striker: striker,
      nonStriker: nonStriker,
      runs: runs,
      faced: faced,
      fours: fours,
      sixs: sixs,
    );
  }

  int foursOf(int batter) {
    return _replay().fours[batter];
  }

  int sixsOf(int batter) {
    return _replay().sixs[batter];
  }

  List<Batters> statsFor(List<String> name) {
    final result = <Batters>[];
    for (int i = 0; i < name.length; i++) {
      if (ballFacedBy(i)==0) {
        continue;
      }
      result.add(
        Batters(
          name: name[i],
          runs: runOf(i),
          balls: ballFacedBy(i),
          fours: foursOf(i),
          sixs: sixsOf(i),
        ),
      );
    }
    return result;
  }
}
