import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:scorekar/features/match/domain/cricket_match.dart';
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
                              color: !isWinnerA ? Colors.white : Colors.grey,
                              fontWeight: !isWinnerA
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${d.teamBScore}/${d.teamBWicket}',
                            style: TextStyle(
                              color: !isWinnerA ? Colors.white : Colors.grey,
                              fontWeight: isWinnerA
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
                        '${d.winner} won the Match',
                        style: TextStyle(fontSize: 20, color: AppColors.accent),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
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

class Stats extends ConsumerWidget {
  final int id;
  const Stats({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(matchDetailProvider(id));
    return stats.when(
      data: (h) {
        final selectedTeam=0;
        return Container(
          
        )
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
