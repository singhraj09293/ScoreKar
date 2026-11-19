import 'package:flutter/material.dart';
import 'package:scorekar/features/match/presentation/screens/history.dart';
import 'package:scorekar/features/match/presentation/screens/new_match.dart';
import 'package:scorekar/theme/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [NewMatch(), History()];
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
        ],
        indicatorColor: AppColors.accent,
      ),
      body: pages[currentIndex],
    );
  }
}
