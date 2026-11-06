enum TossChoice { bats, bowl }

class MatchInfo {
  final String teamA;
  final String teamB;
  final List<String> teamAPlayers;
  final List<String> teamBPlayers;
  final int tossWinner; //0 or 1
  final TossChoice tossChoice;

  const MatchInfo({
    required this.teamA,
    required this.teamB,
    required this.teamAPlayers,
    required this.teamBPlayers,  this.tossWinner=0,  this.tossChoice=TossChoice.bats,
  });

  int get battingFirst => tossChoice == TossChoice.bats ? tossWinner : 1 - tossWinner;
}
