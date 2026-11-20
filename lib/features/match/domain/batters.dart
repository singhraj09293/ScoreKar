class Batters {
  final String name;
  final int runs;
  final int balls;
  final int fours;
  final int sixs;
  final String team;

  Batters({
    required this.name,
    required this.runs,
    required this.balls,
    required this.fours,
    required this.sixs,
    this.team = '',
  });

  double get strikeRate => balls == 0 ? 0 : runs / balls * 100;
}
