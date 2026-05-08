import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../providers/game_provider.dart';
import '../providers/game_settings_provider.dart';
import '../providers/teams_provider.dart';
import '../providers/timer_provider.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({
    required this.categoryId,
    super.key,
  });

  final String categoryId;

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeGame();
    });
  }

  Future<void> _initializeGame() async {
    if (_isInitialized) return;

    try {
      await ref.read(gameProvider.notifier).startGame(widget.categoryId);

      ref.read(timerProvider.notifier).startTimer(
            onComplete: _handleGameEnd,
          );

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Помилка: $e')),
        );
        context.go('/categories');
      }
    }
  }

  void _handleGameEnd() {
    ref.read(gameProvider.notifier).endGame();
    if (mounted) {
      context.go('/result');
    }
  }

  void _handleGuess() => ref.read(gameProvider.notifier).guessWord();
  void _handleSkip() => ref.read(gameProvider.notifier).skipWord();

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gameProvider);
    final timeRemaining = ref.watch(timerProvider);
    final teams = ref.watch(teamsProvider);
    final settings = ref.watch(gameSettingsProvider);
    final teamName = teams.isNotEmpty ? teams.first : 'Team';

    if (game == null || !_isInitialized) {
      return const Scaffold(
        backgroundColor: Color(0xFF2D3D8B),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    final progress = (timeRemaining / settings.timeRound).clamp(0.0, 1.0);

    return Scaffold(
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (!game.hasMoreWords) return;
          final v = details.primaryVelocity ?? 0;
          if (v < -300) _handleGuess();
          if (v > 300) _handleSkip();
        },
        child: Container(
          color: const Color(0xFF2D3D8B),
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.15,
                  child: SvgPicture.asset(
                    'assets/background-frame.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
            child: Column(
              children: [
                // ── Top bar ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          ref.read(timerProvider.notifier).stopTimer();
                          context.go('/home');
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              teamName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Gilroy',
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '+${game.correctCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 36),
                    ],
                  ),
                ),

                // ── Timer number ──────────────────────────────────────
                Text(
                  '$timeRemaining',
                  style: TextStyle(
                    color: timeRemaining <= 10 ? Colors.red[300] : Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Gilroy',
                  ),
                ),

                const SizedBox(height: 8),

                // ── Progress bar ──────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: Colors.white.withValues(alpha: 0.25),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // ── Guessed hint ──────────────────────────────────────
                GestureDetector(
                  onTap: game.hasMoreWords ? _handleGuess : null,
                  child: const Column(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: Colors.white70,
                        size: 32,
                      ),
                      Text(
                        'Guessed',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ── Word card ─────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            game.hasMoreWords
                                ? game.currentWord
                                : 'Слова закінчились!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Gilroy',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Pass hint ─────────────────────────────────────────
                GestureDetector(
                  onTap: game.hasMoreWords ? _handleSkip : null,
                  child: const Column(
                    children: [
                      Text(
                        'Pass',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white70,
                        size: 32,
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // ── Explanation button ────────────────────────────────
                Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: Color(0xFF2D3D8B),
                          size: 14,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Explanation of the word',
                          style: TextStyle(
                            color: Color(0xFF2D3D8B),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),        ],
          ),        ),
      ),
    );
  }
}
