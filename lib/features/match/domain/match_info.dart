// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    required this.teamBPlayers,
    this.tossWinner = 0,
    this.tossChoice = TossChoice.bats,
  });

  MatchInfo copyWith({
    String? teamA,
    String? teamB,
    List<String>? teamAPlayers,
    List<String>? teamBPlayers,
    int? tossWinner,
    TossChoice? tossChoice,
  }) {
    return MatchInfo(
      teamA: teamA ?? this.teamA,
      teamB: teamB ?? this.teamB,
      teamAPlayers: teamAPlayers ?? this.teamAPlayers,
      teamBPlayers: teamBPlayers ?? this.teamBPlayers,
      tossWinner: tossWinner ?? this.tossWinner,
      tossChoice: tossChoice ?? this.tossChoice,
    );
  }

  int get battingFirst =>
      tossChoice == TossChoice.bats ? tossWinner : 1 - tossWinner;

 
}
