import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/presentation/match_controller.dart';

class ScorePage extends ConsumerStatefulWidget {
  const ScorePage({super.key});

  @override
  ConsumerState<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends ConsumerState<ScorePage> {
  @override
  Widget build(BuildContext context) {
    final totalscore = ref.watch(matchProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${totalscore.totalRuns} score'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(matchProvider.notifier).addBall(Ball(run: 1));
              },
              child: Text('Increase Score'),
            ),
          ],
        ),
      ),
    );
  }
}
