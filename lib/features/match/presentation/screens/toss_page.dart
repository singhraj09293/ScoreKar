// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scorekar/features/match/domain/match_info.dart';
import 'package:scorekar/features/match/presentation/screens/coin_flip.dart';
import 'package:scorekar/features/match/presentation/provider/match_controller.dart';
import 'package:scorekar/features/match/presentation/screens/player_selection.dart';
import 'package:scorekar/theme/app_colors.dart';

class TossPage extends ConsumerStatefulWidget {
  const TossPage({super.key});

  @override
  ConsumerState<TossPage> createState() => _TossPageState();
}

class _TossPageState extends ConsumerState<TossPage> {
  int? winner;
  TossChoice? toss;
  bool decidedByCoin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Toss')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Who won the toss', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 18,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: winner == 0 ? AppColors.accent : AppColors.card,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      ref.read(matchinfoProvider).teamA,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: winner == 1 ? AppColors.accent : AppColors.card,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      ref.read(matchinfoProvider).teamB,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                if (decidedByCoin) return;
                final result = await showCoinFlipDialog(
                  context,
                  teamA: ref.read(matchinfoProvider).teamA,
                  teamB: ref.read(matchinfoProvider).teamB,
                );
                if (!mounted) return;
                if (result != null) {
                  setState(() {
                    winner = result;
                    decidedByCoin = true;
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.toll,
                    color: decidedByCoin ? Colors.grey : AppColors.accent,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Flip a coin',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('Choose to', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (winner != null) {
                        setState(() {
                          toss = TossChoice.bats;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: toss == TossChoice.bats
                            ? AppColors.accent
                            : AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.sports_cricket,
                            color: toss == TossChoice.bats
                                ? Colors.black
                                : Colors.white,
                          ),
                          Text(
                            'Batting',
                            style: TextStyle(
                              fontSize: 18,
                              color: toss == TossChoice.bats
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (winner != null) {
                        setState(() {
                          toss = TossChoice.bowl;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: toss == TossChoice.bowl
                            ? AppColors.accent
                            : AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.sports_baseball,
                            color: toss == TossChoice.bowl
                                ? Colors.black
                                : Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Bowling',
                            style: TextStyle(
                              fontSize: 18,
                              color: toss == TossChoice.bowl
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: winner != null && toss != null
                      ? AppColors.accent
                      : Colors.grey,
                  minimumSize: Size(450, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                onPressed: () {
                  if (winner != null && toss != null) {
                    ref
                        .read(matchinfoProvider.notifier)
                        .setToss(winner!, toss!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PlayerSelection()),
                    );
                  }
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
