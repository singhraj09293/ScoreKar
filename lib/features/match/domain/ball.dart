enum BallType { noBall, normal, wide, wicket }

class Ball {
  final int run;
  final BallType type;

  Ball({required this.run, this.type = BallType.normal});

  bool get isLegal => type != BallType.wide && type != BallType.noBall;
}
