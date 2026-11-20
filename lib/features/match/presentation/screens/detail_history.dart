import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:scorekar/features/match/presentation/provider/database_provider.dart';
import 'package:scorekar/theme/app_colors.dart';

class DetailHistory extends ConsumerStatefulWidget {
  final int matchId;
  const DetailHistory({super.key, required this.matchId});

  @override
  ConsumerState<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends ConsumerState<DetailHistory> {
  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(detailProvider(widget.matchId));

    return detail.when(
      data: (d) {
        final isWinnerA = d.teamA == d.winner;
        final isWinnerB = d.teamB == d.winner;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Match',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('d MMM').format(d.playedAt),
                        style: TextStyle(
                          color: Color(0xffE1BFB5),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            d.teamA,
                            style: TextStyle(
                              color: isWinnerA ? Colors.white : Colors.grey,
                              fontWeight: isWinnerA
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${d.teamAScore}/${d.teamAWicket}',
                            style: TextStyle(
                              color: isWinnerA ? Colors.white : Colors.grey,
                              fontWeight: isWinnerA
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            d.teamB,
                            style: TextStyle(
                              color: isWinnerB ? Colors.white : Colors.grey,
                              fontWeight: isWinnerB
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${d.teamBScore}/${d.teamBWicket}',
                            style: TextStyle(
                              color: isWinnerB ? Colors.white : Colors.grey,
                              fontWeight: isWinnerB
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Divider(color: Colors.grey, thickness: 0.5),
                      SizedBox(height: 5),
                      Text(
                        d.winner == 'Tie'
                            ? 'Match Tie'
                            : '${d.winner} won the Match',
                        style: TextStyle(fontSize: 20, color: AppColors.accent),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(child: Stats(id: widget.matchId)),
              ],
            ),
          ),
        );
      },
      error: (e, st) {
        return Scaffold(body: Center(child: Text('$e something wrong')));
      },
      loading: () {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

class Stats extends ConsumerStatefulWidget {
  final int id;
  const Stats({super.key, required this.id});

  @override
  ConsumerState<Stats> createState() => _StatsState();
}

class _StatsState extends ConsumerState<Stats> {
  int selectedTeam = 0;
  @override
  Widget build(BuildContext context) {
    final stats = ref.watch(matchDetailProvider(widget.id));
    return stats.when(
      data: (h) {
        final squad = selectedTeam == 0
            ? h.info.teamAPlayers
            : h.info.teamBPlayers;
        final inning = selectedTeam == h.info.battingFirst
            ? h.innings1
            : h.innings2!;
        final batters = inning.statsFor(squad);
        final didNotBat = <String>[];
        for (final naam in squad) {
          bool khela = false;
          for (final b in batters) {
            if (b.name == naam) {
              khela = true;
            }
          }
          if (!khela) {
            didNotBat.add(naam);
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.black),
              child: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTeam = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: selectedTeam == 0
                              ? AppColors.accent
                              : AppColors.card,
                        ),
                        child: Text(
                          h.info.teamA,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTeam = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),

                          color: selectedTeam == 1
                              ? AppColors.accent
                              : AppColors.card,
                        ),
                        child: Text(
                          h.info.teamB,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'BATTING',
              style: TextStyle(fontSize: 15, color: Color(0xffE1BFB5)),
            ),
            SizedBox(height: 10),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      spacing: 25,
                      children: [
                        Text(
                          'Batter',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffE1BFB5),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'R',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffE1BFB5),
                          ),
                        ),
                        Text(
                          'B',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffE1BFB5),
                          ),
                        ),
                        Text(
                          '4s',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xffE1BFB5),
                          ),
                        ),
                        Text(
                          '6s',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xffE1BFB5),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Color.fromARGB(255, 58, 58, 66),
                      thickness: 1.5,
                    ),
                    SizedBox(height: 10),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: batters.length,
                        itemBuilder: (context, index) {
                          final sorted = List.of(batters);
                          sorted.sort((a, b) => b.runs.compareTo(a.runs));
                          final b = sorted[index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _playerStats(
                                      b.name,
                                      b.runs,
                                      b.balls,
                                      b.fours,
                                      b.sixs,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Divider(
                                color: Colors.grey.shade600,
                                thickness: 1,
                              ),
                              SizedBox(height: 5),
                            ],
                          );
                        },
                      ),
                    ),
                    if (didNotBat.isNotEmpty)
                      Row(
                        spacing: 33,
                        children: [
                          Text(
                            didNotBat.join(', '),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text('0', style: TextStyle(fontSize: 18)),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Color(0xffE1BFB5),
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Color(0xffE1BFB5),
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Color(0xffE1BFB5),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    if (didNotBat.isNotEmpty) SizedBox(height: 5),
                    if (didNotBat.isNotEmpty)
                      Divider(color: Colors.grey.shade600, thickness: 1),
                    if (didNotBat.isNotEmpty) SizedBox(height: 20),

                    Row(
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${inning.totalRuns}/${inning.wickets}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '(${inning.overs})',
                          style: TextStyle(
                            color: Color(0xffE1BFB5),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      error: (e, st) {
        return Center(child: Text('$e something wrong'));
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

Widget _playerStats(String name, int r, int b, int f, int s) {
  return Row(
    spacing: 34,
    children: [
      Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Spacer(),
      Text('$r', style: TextStyle(fontSize: 18)),
      Text('$b', style: TextStyle(color: Color(0xffE1BFB5), fontSize: 18)),
      Text('$f', style: TextStyle(color: Color(0xffE1BFB5), fontSize: 18)),
      Text('$s', style: TextStyle(color: Color(0xffE1BFB5), fontSize: 18)),
    ],
  );
}
