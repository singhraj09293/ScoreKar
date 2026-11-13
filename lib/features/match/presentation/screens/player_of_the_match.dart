import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/presentation/provider/match_controller.dart';
import 'package:scorekar/theme/app_colors.dart';

class PlayerOfTheMatch extends ConsumerStatefulWidget {
  const PlayerOfTheMatch({super.key});

  @override
  ConsumerState<PlayerOfTheMatch> createState() => _PlayerOfTheMatchState();
}

class _PlayerOfTheMatchState extends ConsumerState<PlayerOfTheMatch> {
  @override
  Widget build(BuildContext context) {
    final match = ref.watch(matchProvider);
    final best = match.playerOfTheMatch;
    return Scaffold(
      body: Center(
        child: best == null
            ? Text('No batting data!', style: TextStyle(fontSize: 40))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 450,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'PLAYER OF THE MATCH',
                            style: TextStyle(
                              color: Color(0xffE1BFB5),
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            best.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            'Team Lion',
                            style: TextStyle(fontSize: 17, color: Colors.grey),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${best.runs}',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 35,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            'RUNS',
                            style: TextStyle(color: Color(0xffE1BFB5)),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xff1E1F23),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              spacing: 12,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _scoreBoard(best.balls, 'Balls'),
                                _scoreBoard(best.sixs, 'Sixs'),
                                _scoreBoard(best.fours, 'Fours'),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff343539),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              spacing: 5,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'SR',
                                  style: TextStyle(
                                    color: Color(0xffE1BFB5),
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  best.strikeRate.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 5,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                'SCOREKAR',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xffB99E97),
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        minimumSize: Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 7,
                        children: [
                          Icon(Icons.share, color: Colors.black),
                          Text(
                            'Share Card',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.card,
                        minimumSize: Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 7,
                        children: [
                          Icon(Icons.download, color: Colors.white),
                          Text(
                            'Save to Photos',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

Widget _scoreBoard(int nos, String label) {
  Color _scoreRuns(int nos) {
    if (nos == 6) {
      return Color(0xff59D5FB);
    } else if (nos == 4) {
      return AppColors.accent;
    } else {
      return Colors.white;
    }
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        '$nos',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: _scoreRuns(nos),
          letterSpacing: 1,
        ),
      ),
      SizedBox(height: 5),
      Text(
        label.toUpperCase(),
        style: TextStyle(
          color: Color(0xffE1BFB5),
          fontSize: 18,
          letterSpacing: 1,
        ),
      ),
    ],
  );
}
