import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/presentation/match_controller.dart';

class ScorePage extends ConsumerStatefulWidget {
  final String a;
  final String b;
  const ScorePage({super.key, required this.a, required this.b});

  @override
  ConsumerState<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends ConsumerState<ScorePage> {
  @override
  Widget build(BuildContext context) {
    final batters = ['Ravi', 'Amit'];
    final score = ref.watch(matchProvider);
    List<int> runs = [0, 1, 2, 4, 6];
    final strikerIdx = score.strikerIndex;
    final nonStrikerIdx = 1 - score.strikerIndex;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Scoring Console',
          style: TextStyle(color: Color(0xff918A80)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.a,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff918A80),
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 5),
              Text(
                '${batters[strikerIdx]}*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              SizedBox(height: 5),
              Text(
                batters[nonStrikerIdx],
                style: TextStyle(color: Color(0xff918A80), fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                '${score.totalRuns}/${score.wickets}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              SizedBox(height: 7,),
              Text(score.overs, style: TextStyle(color: Color(0xff918A80))),
            ],
          ),
        ),
      ),
    );
  }
}
