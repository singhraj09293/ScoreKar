import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/presentation/provider/match_controller.dart';
import 'package:scorekar/features/match/presentation/screens/new_match.dart';
import 'package:scorekar/features/match/presentation/screens/player_of_the_match.dart';
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
    if (match.marginText == null) {
      return const Scaffold(
        body: Center(child: Text('Match is not finished yet')),
      );
    }
    final info = ref.watch(matchinfoProvider);
    final firstName = info.battingFirst == 0 ? info.teamA : info.teamB;
    final secondName = info.battingFirst == 0 ? info.teamB : info.teamA;
    final firstWon = match.winnerName == firstName;
    final secondWon = match.winnerName == secondName;
    return Scaffold(
      appBar: AppBar(title: Text('Result', style: TextStyle(fontSize: 20))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(height: 10),
              Text(
                match.winnerName ?? 'Match Tied',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              SizedBox(height: 5),
              if (match.winnerName != null)
                Text(
                  match.marginText ?? '',
                  style: TextStyle(color: Color(0xffA98A80), fontSize: 20),
                ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            firstName,
                            style: TextStyle(
                              fontWeight: firstWon
                                  ? FontWeight.w700
                                  : FontWeight.normal,
                              fontSize: 23,
                              color: firstWon ? Colors.white : Colors.grey,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${match.innings1.totalRuns}/${match.innings1.wickets}',
                            style: TextStyle(
                              fontWeight: firstWon
                                  ? FontWeight.w700
                                  : FontWeight.w100,
                              color: firstWon ? Colors.white : Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            match.innings1.overs,
                            style: TextStyle(
                              color: Color(0xffA98A80),
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      Divider(color: AppColors.background),
                      Row(
                        children: [
                          Text(
                            secondName,
                            style: TextStyle(
                              fontWeight: secondWon
                                  ? FontWeight.w700
                                  : FontWeight.normal,
                              fontSize: 23,
                              color: secondWon ? Colors.white : Colors.grey,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${match.innings2!.totalRuns}/${match.innings2!.wickets}',
                            style: TextStyle(
                              fontWeight: secondWon
                                  ? FontWeight.w700
                                  : FontWeight.normal,
                              fontSize: 20,
                              color: secondWon ? Colors.white : Colors.grey,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            match.innings2!.overs,
                            style: TextStyle(
                              color: Color(0xffA98A80),
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const NewMatch()),
                    (route) => false,
                  );
                },
                child: Text(
                  'New Match',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PlayerOfTheMatch()),
                ),
                child: Container(
                  color: Colors.transparent,
                  child: Text(
                    'View Player of the match',
                    style: TextStyle(color: Color(0xffA98A80)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
