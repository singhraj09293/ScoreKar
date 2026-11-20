import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:scorekar/features/match/presentation/provider/database_provider.dart';
import 'package:scorekar/features/match/presentation/screens/detail_history.dart';
import 'package:scorekar/theme/app_colors.dart';

class History extends ConsumerStatefulWidget {
  const History({super.key});

  @override
  ConsumerState<History> createState() => _HistoryState();
}

class _HistoryState extends ConsumerState<History> {
  void _showDialog(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Delete this Match?',
          style: TextStyle(color: AppColors.accent, fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(dbProvider).deleteMatch(id);
              ref.invalidate(historyProvider);
              if (!mounted) return;
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(historyProvider);
    return history.when(
      data: (row) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Match Overview',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: row.length,
                    itemBuilder: (context, index) {
                      final matchs = row[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailHistory(matchId: matchs.id),
                          ),
                        ),
                        onLongPress: () => _showDialog(matchs.id),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.card,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('d MMM').format(matchs.playedAt),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xffA98A80),
                                ),
                              ),
                              SizedBox(height: 17),
                              Row(
                                children: [
                                  Text(
                                    matchs.teamA,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: matchs.winner == matchs.teamA
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: matchs.winner == matchs.teamA
                                          ? FontWeight.bold
                                          : FontWeight.w400,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${matchs.teamAScore}/${matchs.teamAWicket}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: matchs.winner == matchs.teamA
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: matchs.winner == matchs.teamA
                                          ? FontWeight.bold
                                          : FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    matchs.teamB,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: matchs.winner == matchs.teamB
                                          ? FontWeight.bold
                                          : FontWeight.w400,
                                      color: matchs.winner == matchs.teamB
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${matchs.teamBScore}/${matchs.teamBWicket}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: matchs.winner == matchs.teamB
                                          ? FontWeight.bold
                                          : FontWeight.w400,
                                      color: matchs.winner == matchs.teamB
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (e, st) {
        return Scaffold(body: Center(child: Text('$e something wrong')));
      },
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
