import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        child: Text('${totalscore.totalRuns} score'),
      ),
    );
  }
}
