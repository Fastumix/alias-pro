import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/utils/colors.dart';
import '../providers/profile_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../settings/presentation/providers/settings_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authProvider);
    final settings = ref.watch(settingsProvider);
    final totalGames = ref.watch(totalGamesProvider);
    final bestScore = ref.watch(bestScoreProvider);
    final categoryStats = ref.watch(categoryStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профіль'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                      child: Text(
                        settings.avatarUrl ?? '😀',
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      settings.userName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    authUser.when(
                      data: (user) => Text(
                        user?.uid.substring(0, 8) ?? 'Анонім',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      loading: () => const CircularProgressIndicator(),
                      error: (_, __) => const Text('Помилка'),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Overall Statistics
            Text(
              'Загальна статистика',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.games_rounded,
                    label: 'Ігор зіграно',
                    value: totalGames.when(
                      data: (count) => count.toString(),
                      loading: () => '...',
                      error: (_, __) => '0',
                    ),
                    color: AppColors.info,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    icon: Icons.emoji_events_rounded,
                    label: 'Кращий рахунок',
                    value: bestScore.when(
                      data: (score) => score.toString(),
                      loading: () => '...',
                      error: (_, __) => '0',
                    ),
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Category Statistics
            Text(
              'Статистика по категоріях',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            
            const SizedBox(height: 16),
            
            categoryStats.when(
              data: (stats) {
                if (stats.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(
                        child: Text(
                          'Ще немає зіграних ігор',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                
                return Column(
                  children: stats.entries.map((entry) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getCategoryName(entry.key),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _MiniStat(
                                  label: 'Ігор',
                                  value: entry.value['gamesPlayed'].toString(),
                                ),
                                _MiniStat(
                                  label: 'Рекорд',
                                  value: entry.value['bestScore'].toString(),
                                ),
                                _MiniStat(
                                  label: 'Вгадано',
                                  value: entry.value['totalCorrect'].toString(),
                                ),
                                _MiniStat(
                                  label: 'Пропущено',
                                  value: entry.value['totalSkips'].toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (_, __) => const Center(
                child: Text('Помилка завантаження статистики'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryName(String categoryId) {
    switch (categoryId) {
      case 'animals':
        return '🦁 Тварини';
      case 'movies':
        return '🎬 Фільми';
      case 'food':
        return '🍕 Їжа';
      case 'sport':
        return '⚽ Спорт';
      case 'history':
        return '👑 Історичні постаті';
      default:
        return categoryId;
    }
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
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
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;

  const _MiniStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
