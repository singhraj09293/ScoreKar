import 'dart:math';
import 'package:flutter/material.dart';

// Entry point function to show the dialog and wait for the result
Future<int?> showCoinFlipDialog(
  BuildContext context, {
  required String teamA,
  required String teamB,
}) {
  return showDialog<int>(
    context: context,
    barrierDismissible: false, // Ignores outside taps while spinning
    barrierColor: const Color(
      0xFF0E0F11,
    ).withValues(alpha: 0.8), // Dark page background
    builder: (context) => _CoinFlipDialog(teamA: teamA, teamB: teamB),
  );
}

// Stateful widget that handles the animation and UI
class _CoinFlipDialog extends StatefulWidget {
  final String teamA;
  final String teamB;

  const _CoinFlipDialog({required this.teamA, required this.teamB});

  @override
  State<_CoinFlipDialog> createState() => _CoinFlipDialogState();
}

// State class with SingleTickerProviderStateMixin for the AnimationController
class _CoinFlipDialogState extends State<_CoinFlipDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int _winner;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    // 1. Choose the winner before the animation starts (0 = Team A, 1 = Team B)
    _winner = Random().nextInt(2);

    // 2. Setup the controller for a 1.6-second duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    // 3. Calculate target angle: 5 full rotations (10 * pi) + an extra half rotation (pi) if B wins
    final double targetAngle = (10 * pi) + (_winner * pi);

    // 4. Apply easeOut curve so the coin naturally slows down as it lands
    _animation = Tween<double>(
      begin: 0,
      end: targetAngle,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // 5. Start the animation and handle the post-landing sequence
    _controller.forward().then((_) async {
      if (!mounted) return;
      setState(() {
        _isFinished = true;
      });

      // Wait 1 second to show the winner text, then auto-close
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      Navigator.of(context).pop(_winner);
    });
  }

  @override
  void dispose() {
    // Always dispose the controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // PopScope prevents Android back-button dismissals while the coin is flipping
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: const Color(0xFF1A1B1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // AnimatedBuilder rebuilds only this widget tree on every frame
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final angle = _animation.value;
                  // Switch the visible face exactly when the coin is edge-on (every pi/2 boundary)
                  final isFrontVisible = ((angle + pi / 2) / pi).floor().isEven;

                  // Render the front or back letter. The back text is flipped by pi around X so it isn't upside down.
                  final faceWidget = isFrontVisible
                      ? Text(
                          widget.teamA[0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateX(pi),
                          child: Text(
                            widget.teamB[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );

                  // Apply the actual 3D rotation to the entire coin
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002) // Adds depth perspective
                      ..rotateX(angle),
                    child: Container(
                      width: 140,
                      height: 140,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B35), Colors.orangeAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: Colors.white24, width: 4),
                      ),
                      child: faceWidget,
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              // Show status text based on animation completion
              Text(
                _isFinished
                    ? "${_winner == 0 ? widget.teamA : widget.teamB} won the toss!"
                    : "Flipping...",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
