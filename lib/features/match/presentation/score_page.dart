import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/domain/match_info.dart';
import 'package:scorekar/features/match/presentation/provider/match_controller.dart';
import 'package:scorekar/theme/app_colors.dart';
import 'dart:math';

class ScorePage extends ConsumerStatefulWidget {
  final String a;
  final String b;
  const ScorePage({super.key, required this.a, required this.b});

  @override
  ConsumerState<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends ConsumerState<ScorePage> {
  Color _runColor(Ball ball) {
    switch (ball.run) {
      case 0:
        return AppColors.card;
      case 1:
      case 2:
        return Colors.grey;
      case 4:
        return AppColors.blue;
      case 6:
        return AppColors.accent;
      default:
        return AppColors.card;
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = ref.watch(matchinfoProvider);
    final battersA = info.teamAPlayers;
    final battersB = info.teamBPlayers;

    final tossWinnerName = info.tossWinner == 0 ? info.teamA : info.teamB;
    final choiceWord = info.tossChoice == TossChoice.bats ? 'bat' : 'bowl';
    final match = ref.watch(matchProvider);
    final score = match.current;
    final batter = match.battingTeam == 0 ? battersA : battersB;
    final ballInOver = score.ballInCurrentOver;
    final strikerIdx = score.strikerIndex;
    final nonStrikerIdx = score.nonStrikerIndex;
    final sublabels = {0: 'DOT', 1: 'SINGLE', 2: 'DOUBLE', 4: 'FOUR', 6: 'SIX'};
    String _ballLabel(Ball ball) {
      switch (ball.type) {
        case BallType.wicket:
          return 'W';
        case BallType.wide:
          return 'wd';
        case BallType.noBall:
          return 'nb';
        case BallType.normal:
          return '${ball.run}';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Scoring Console',
          style: TextStyle(color: Color(0xff918A80)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (match.isFirstInning && score.isInningOver)
                  Text(
                    ('$tossWinnerName has won the toss and chose to $choiceWord First'),
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff918A80),
                      letterSpacing: 2,
                    ),
                  ),
                if (!match.isFirstInning)
                  Text(
                    'Target Runs  ${match.target}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff918A80),
                      letterSpacing: 2,
                    ),
                  ),
                SizedBox(height: 10),
                Text(
                  info.battingFirst == 0 ? info.teamA : info.teamB,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff918A80),
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sports_cricket, color: AppColors.accent),
                    SizedBox(width: 5),
                    Text(
                      strikerIdx < batter.length
                          ? '${batter[strikerIdx]} *'
                          : 'All Out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      strikerIdx < batter.length
                          ? '${score.runOf(strikerIdx)} (${score.ballFacedBy(strikerIdx)})'
                          : '',
                      style: TextStyle(color: Color(0xff918A80), fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nonStrikerIdx < batter.length
                          ? batter[nonStrikerIdx]
                          : '-',
                      style: TextStyle(color: Color(0xff918A80), fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Text(
                      nonStrikerIdx < batter.length
                          ? '${score.runOf(nonStrikerIdx)} (${score.ballFacedBy(nonStrikerIdx)})'
                          : '',
                      style: TextStyle(color: Color(0xff918A80), fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  '${score.totalRuns}/${score.wickets}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                SizedBox(height: 10),
                Text(
                  score.overs,
                  style: TextStyle(color: Color(0xff918A80), fontSize: 20),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: Row(
                    spacing: 8,
                    children: [
                      ...List.generate(6, (i) {
                        return Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: i < ballInOver
                                  ? AppColors.accent
                                  : AppColors.card,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'BALL ${score.ballInCurrentOver} OF 6',
                        style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        '${score.ballsRemainingInOver} REMAINIG',
                        style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      ...score.balls
                          .skip(max(0, score.balls.length - 6))
                          .map(
                            (b) => Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: b.type == BallType.wicket
                                    ? Color(0xffDC2626)
                                    : _runColor(b),
                              ),
                              child: Text(
                                _ballLabel(b),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  spacing: 12,
                  children: [
                    ...[0, 1, 2].map(
                      (r) => Expanded(
                        child: _runsContainer(
                          label: '$r',
                          color: score.isInningOver
                              ? Colors.grey
                              : AppColors.card,
                          onTap: () {
                            score.isInningOver
                                ? null
                                : ref
                                      .read(matchProvider.notifier)
                                      .addBall(Ball(run: r));
                          },
                          sublabel: sublabels[r],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  spacing: 12,
                  children: [
                    ...[4, 6].map(
                      (r) => Expanded(
                        child: _runsContainer(
                          label: '$r',
                          color: score.isInningOver
                              ? Colors.grey
                              : (r == 4 ? AppColors.blue : AppColors.accent),
                          onTap: () {
                            score.isInningOver
                                ? null
                                : ref
                                      .read(matchProvider.notifier)
                                      .addBall(Ball(run: r));
                          },
                          sublabel: sublabels[r],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: _runsContainer(
                        label: 'WIDE',
                        color: score.isInningOver
                            ? Colors.grey
                            : AppColors.card,
                        onTap: () {
                          score.isInningOver
                              ? null
                              : ref
                                    .read(matchProvider.notifier)
                                    .addBall(Ball(run: 0, type: BallType.wide));
                        },
                      ),
                    ),
                    Expanded(
                      child: _runsContainer(
                        label: 'NO BALL',
                        color: score.isInningOver
                            ? Colors.grey
                            : AppColors.card,
                        onTap: () {
                          score.isInningOver
                              ? null
                              : ref
                                    .read(matchProvider.notifier)
                                    .addBall(
                                      Ball(run: 0, type: BallType.noBall),
                                    );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _runsContainer(
                  label: 'WICKET',
                  color: score.isInningOver ? Colors.grey : Color(0XFFDC2626),
                  onTap: () {
                    score.isInningOver
                        ? null
                        : ref
                              .read(matchProvider.notifier)
                              .addBall(Ball(run: 0, type: BallType.wicket));
                  },
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    ref.read(matchProvider.notifier).undo();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.undo, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(
                        'UNDO LAST BALL',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                if (match.isFirstInning && score.isInningOver)
                  _runsContainer(
                    label: '2nd Inning',
                    color: Color(0XFFDC2626),
                    onTap: () {
                      ref.read(matchProvider.notifier).startSecondInning();
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _runsContainer({
  required String label,
  required Color color,
  required VoidCallback? onTap,
  String? sublabel,
  double height = 64,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),

        color: color,
        border: Border.all(
          color: label == '4' || label == '6' || label == 'WICKET'
              ? Colors.transparent
              : Colors.grey,
        ),
      ),
      child: label == '4' || label == '6'
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
                if (sublabel != null)
                  Text(sublabel, style: TextStyle(fontSize: 12)),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                if (sublabel != null)
                  Text(
                    sublabel,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
              ],
            ),
    ),
  );
}
