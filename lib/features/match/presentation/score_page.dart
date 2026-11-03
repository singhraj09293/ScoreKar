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
    List<int> runs = [0, 1, 2, 4, 6];
    return Scaffold(
      body: Center(
        child:totalscore.isInningOver ? Text('Inning Over'): Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Score Board'),
                  Text('${totalscore.totalRuns}/${totalscore.wickets}'),
                  Text('${totalscore.overs} overs')
                ],
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              children: [
                ...runs.map(
                  (n) => ElevatedButton(
                    onPressed: totalscore.isInningOver ? null :  () =>
                        ref.read(matchProvider.notifier).addBall(Ball(run: n)),
                    child: Text('$n'),
                  ),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed:totalscore.isInningOver ? null : () {
                    ref.read(matchProvider.notifier).undo();
                  },
                  child: Text('Undo'),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: totalscore.isInningOver ? null :() {
                        ref
                            .read(matchProvider.notifier)
                            .addBall(Ball(run: 0, type: BallType.wide));
                      },
                      child: Text('Wide'),
                    ),
                    ElevatedButton(
                      onPressed:totalscore.isInningOver ? null : () {
                        ref
                            .read(matchProvider.notifier)
                            .addBall(Ball(run: 0, type: BallType.noBall));
                      },
                      child: Text('no Ball'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed:totalscore.isInningOver ? null : () {
                    ref
                        .read(matchProvider.notifier)
                        .addBall(Ball(run: 0, type: BallType.wicket));
                  },
                  child: Text('Wickett!'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
