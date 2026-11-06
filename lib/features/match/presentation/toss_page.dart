// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scorekar/features/match/domain/match_info.dart';
import 'package:scorekar/features/match/presentation/coin_flip.dart';
import 'package:scorekar/features/match/presentation/match_controller.dart';
import 'package:scorekar/theme/app_colors.dart';

class TossPage extends ConsumerStatefulWidget {
  int? winner;
  TossChoice? toss;
  TossPage({super.key, this.winner, this.toss});

  @override
  ConsumerState<TossPage> createState() => _TossPageState();
}

class _TossPageState extends ConsumerState<TossPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Toss')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Who won the toss'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 18,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      widget.winner = 0;
                    }),
                    child: Container(
                      padding: EdgeInsets.all(30),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: widget.winner == 0
                            ? AppColors.accent
                            : AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        ref.read(matchinfoProvider).teamA,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      widget.winner = 1;
                    }),
                    child: Container(
                      padding: EdgeInsets.all(30),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: widget.winner == 1
                            ? AppColors.accent
                            : AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        ref.read(matchinfoProvider).teamB,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final result = await showCoinFlipDialog(
                  context,
                  teamA: ref.read(matchinfoProvider).teamA,
                  teamB: ref.read(matchinfoProvider).teamB,
                );
                if (!mounted) return;
                if (result != null) setState(() => widget.winner = result);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.toll, color: AppColors.accent),
                  SizedBox(width: 5),
                  Text(
                    'Flip a coin',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                minimumSize: Size(450, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
              onPressed: () {},
              child: Text(''),
            ),
          ],
        ),
      ),
    );
  }
}
