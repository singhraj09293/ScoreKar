import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/presentation/screens/new_match.dart';
import 'package:scorekar/features/match/presentation/screens/result_screen.dart';
import 'package:scorekar/features/match/presentation/screens/score_page.dart';
import 'package:scorekar/theme/app_colors.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        cardTheme: CardThemeData(color: AppColors.card),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        colorScheme: const ColorScheme.dark(primary: AppColors.accent),
      ),
      debugShowCheckedModeBanner: false,
      home: ResultScreen(),
    );
  }
}
