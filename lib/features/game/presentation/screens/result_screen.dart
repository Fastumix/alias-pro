import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/utils/colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../providers/game_provider.dart';
import '../../../profile/data/datasources/local_storage_datasource.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _saveResult();
    });
  }

  Future<void> _saveResult() async {
    if (_isSaved) return;
    
    final gameResult = ref.read(gameProvider.notifier).getGameResult();
    
    if (gameResult != null) {
      await ref.read(localStorageProvider).saveGameResult(gameResult);
      setState(() {
        _isSaved = true;
      });
    }
  }

  void _handlePlayAgain() {
    final game = ref.read(gameProvider);
    ref.read(gameProvider.notifier).resetGame();
    
    if (game != null) {
      context.go('/game/${game.categoryId}');
    } else {
      context.go('/categories');
    }
  }

  void _handleGoHome() {
    ref.read(gameProvider.notifier).resetGame();
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final gameResult = ref.read(gameProvider.notifier).getGameResult();

    if (gameResult == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Немає результатів гри'),
              const SizedBox(height: 16),
              CustomButton(
                text: 'На головну',
                onPressed: _handleGoHome,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Game Over Title
              const Icon(
                Icons.emoji_events_rounded,
                size: 80,
                color: AppColors.warning,
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'Гра закінчена!',
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 48),
              
              // Score Display
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.success.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Score',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${gameResult.score}',
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Statistics
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.check_circle_rounded,
                      label: 'Вгадано',
                      value: gameResult.correctCount.toString(),
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.skip_next_rounded,
                      label: 'Пропущено',
                      value: gameResult.skipCount.toString(),
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Action Buttons
              CustomButton(
                text: 'Грати ще',
                onPressed: _handlePlayAgain,
                isExpanded: true,
                icon: Icons.replay_rounded,
              ),
              
              const SizedBox(height: 16),
              
              CustomButton(
                text: 'На головну',
                onPressed: _handleGoHome,
                isExpanded: true,
                icon: Icons.home_rounded,
                backgroundColor: AppColors.surface,
                textColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
