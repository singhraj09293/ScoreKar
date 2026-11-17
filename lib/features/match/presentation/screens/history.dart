import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/presentation/provider/database_provider.dart';
import 'package:scorekar/theme/app_colors.dart';

class History extends ConsumerStatefulWidget {
  const History({super.key});

  @override
  ConsumerState<History> createState() => _HistoryState();
}

class _HistoryState extends ConsumerState<History> {
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
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: row.length,
                  itemBuilder: (context, index) {
                    final matchs = row[index];
                    return Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.card,
                      ),
                      child: Column(
                 
                        children: [
                          Text(
                            matchs.playedAt.toString(),
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
                                  fontWeight: matchs.winner == matchs.teamA
                                      ? FontWeight.bold
                                      : FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                matchs.teamB,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: matchs.winner == matchs.teamB
                                      ? FontWeight.bold
                                      : FontWeight.w400,
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
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      error: (e, st) {
        print(e);
        print(st);
        return Scaffold(body: Center(child: Text('$e something wrong')));
      },
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
