import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/domain/cricket_match.dart';
import 'package:scorekar/features/match/presentation/provider/match_controller.dart';
import 'package:scorekar/theme/app_colors.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final match = ref.watch(matchProvider);
    final info = ref.watch(matchinfoProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Result', style: TextStyle(fontSize: 20))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.card,
                border: Border.all(color: AppColors.accent, width: 0.5),
              ),
              child: Icon(
                Icons.emoji_events,
                color: AppColors.accent,
                size: 35,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'MATCH RESULT',
              style: TextStyle(color: Color(0xffA98A80), fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              match.winnerName ?? 'Match Tied',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              match.marginText ?? 'no one won',
              style: TextStyle(color: Color(0xffA98A80)),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                       match.battingTeam==0 ? info.teamA :info.teamB,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(info.teamA==match.winnerName ? ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
