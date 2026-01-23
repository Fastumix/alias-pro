import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/constants.dart';
import '../../../game/domain/entities/game_result.dart';

final localStorageProvider = Provider<LocalStorageDatasource>((ref) {
  return LocalStorageDatasource();
});

class LocalStorageDatasource {
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  /// Save game result to local storage
  Future<void> saveGameResult(GameResult result) async {
    final prefs = await _prefs;
    
    // Get existing results
    final List<GameResult> results = await getGameResults();
    
    // Add new result
    results.add(result);
    
    // Save back to storage
    final jsonList = results.map((r) => r.toJson()).toList();
    await prefs.setString(
      AppConstants.localBestScoresKey,
      json.encode(jsonList),
    );
    
    // Increment total games played
    final totalGames = await getTotalGamesPlayed();
    await prefs.setInt(AppConstants.totalGamesPlayedKey, totalGames + 1);
  }

  /// Get all game results from local storage
  Future<List<GameResult>> getGameResults() async {
    final prefs = await _prefs;
    final String? jsonString = prefs.getString(AppConstants.localBestScoresKey);
    
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    
    try {
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => GameResult.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Get best score for a specific category
  Future<int> getBestScoreForCategory(String categoryId) async {
    final results = await getGameResults();
    
    final categoryResults = results
        .where((r) => r.categoryId == categoryId)
        .toList();
    
    if (categoryResults.isEmpty) {
      return 0;
    }
    
    return categoryResults
        .map((r) => r.score)
        .reduce((a, b) => a > b ? a : b);
  }

  /// Get overall best score across all categories
  Future<int> getOverallBestScore() async {
    final results = await getGameResults();
    
    if (results.isEmpty) {
      return 0;
    }
    
    return results
        .map((r) => r.score)
        .reduce((a, b) => a > b ? a : b);
  }

  /// Get total games played
  Future<int> getTotalGamesPlayed() async {
    final prefs = await _prefs;
    return prefs.getInt(AppConstants.totalGamesPlayedKey) ?? 0;
  }

  /// Clear all local data
  Future<void> clearAllData() async {
    final prefs = await _prefs;
    await prefs.remove(AppConstants.localBestScoresKey);
    await prefs.remove(AppConstants.totalGamesPlayedKey);
  }

  /// Get statistics by category
  Future<Map<String, Map<String, int>>> getCategoryStatistics() async {
    final results = await getGameResults();
    final Map<String, Map<String, int>> stats = {};
    
    for (final result in results) {
      if (!stats.containsKey(result.categoryId)) {
        stats[result.categoryId] = {
          'gamesPlayed': 0,
          'bestScore': 0,
          'totalCorrect': 0,
          'totalSkips': 0,
        };
      }
      
      final categoryStats = stats[result.categoryId]!;
      categoryStats['gamesPlayed'] = (categoryStats['gamesPlayed'] ?? 0) + 1;
      categoryStats['totalCorrect'] = 
          (categoryStats['totalCorrect'] ?? 0) + result.correctCount;
      categoryStats['totalSkips'] = 
          (categoryStats['totalSkips'] ?? 0) + result.skipCount;
      
      final currentBest = categoryStats['bestScore'] ?? 0;
      if (result.score > currentBest) {
        categoryStats['bestScore'] = result.score;
      }
    }
    
    return stats;
  }
}
