import 'package:flutter/material.dart';
import 'package:scorekar/features/match/presentation/screens/main_screen.dart'; // apna asli path

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    precacheImage(const AssetImage('assets/images/icon.png'), context).then((
      _,
    ) {
      if (!mounted) return;
      _c.forward().then((_) async {
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      });
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = Tween<double>(
      begin: 1.0,
      end: 220 / w,
    ).animate(CurvedAnimation(parent: _c, curve: Curves.easeInOutCubic));
    final textOpacity = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
    );
    return Scaffold(
      backgroundColor: const Color(0xFF1C1917),
      body: Stack(
        children: [
          Center(
            child: ScaleTransition(
              scale: scale,
              child: Image.asset('assets/images/icon.png', width: w),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.55),
            child: FadeTransition(
              opacity: textOpacity,
              child: const Text(
                'Scorekar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
