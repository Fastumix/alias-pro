import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class GameStartScreen extends StatelessWidget {
  final String teamName;
  final int round;
  final int teamScore;
  final String categoryId;

  const GameStartScreen({
    required this.teamName,
    required this.round,
    required this.teamScore,
    required this.categoryId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF2D3D8B);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: bgColor,
        child: Stack(
          children: [
            // Background topographic pattern
            Positioned.fill(
              child: Opacity(
                opacity: 0.15,
                child: SvgPicture.asset(
                  'assets/background-frame.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Center content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Round $round',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Walking team',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10,),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          teamName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1C2659),
                            fontFamily: 'Gilroy',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '$teamScore point',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1C2659),
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Start Game button
            Positioned(
              left: 16,
              right: 16,
              bottom: 32,
              child: _StartGameButton(
                onTap: () => context.push('/game/$categoryId'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StartGameButton extends StatelessWidget {
  final VoidCallback onTap;
  const _StartGameButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
              color: Colors.white.withValues(alpha: 0.25), width: 1,),
        ),
        child: Row(
          children: [
            // Left pill
            Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(36),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Start Game',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C2659),
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
            const Spacer(),
            // Chevron indicators (fading left → right)
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: List.generate(3, (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white.withValues(alpha: 0.25 + i * 0.3),
                    size: 24,
                  ),
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
