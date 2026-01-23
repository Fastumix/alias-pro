import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local_storage_datasource.dart';

final totalGamesProvider = FutureProvider<int>((ref) async {
  final localStorage = ref.watch(localStorageProvider);
  return await localStorage.getTotalGamesPlayed();
});

final bestScoreProvider = FutureProvider<int>((ref) async {
  final localStorage = ref.watch(localStorageProvider);
  return await localStorage.getOverallBestScore();
});

final categoryStatsProvider = FutureProvider<Map<String, Map<String, int>>>(
  (ref) async {
    final localStorage = ref.watch(localStorageProvider);
    return await localStorage.getCategoryStatistics();
  },
);
