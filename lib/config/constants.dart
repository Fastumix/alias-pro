class AppConstants {
  // Game Settings
  static const int gameDurationSeconds = 90;
  static const int pointsForCorrect = 1;
  static const int pointsForSkip = -1;
  static const int minimumScore = 0;
  
  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration timerUpdateInterval = Duration(seconds: 1);
  
  // Firestore Collections
  static const String usersCollection = 'users';
  
  // SharedPreferences Keys
  static const String localBestScoresKey = 'local_best_scores';
  static const String totalGamesPlayedKey = 'total_games_played';
  
  // Categories File
  static const String categoriesJsonPath = 'assets/data/categories.json';
  
  AppConstants._();
}
