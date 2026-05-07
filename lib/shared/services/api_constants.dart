class ApiConstants {
  // Change this to your production URL before deploying.
  // For Android emulator use 10.0.2.2 instead of localhost.
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  static const String v1 = '/v1';

  // Auth
  static const String authRegister = '$v1/auth/register';
  static const String authLogin = '$v1/auth/login';
  static const String authFirebase = '$v1/auth/firebase';

  // Users
  static const String users = '$v1/users';

  // Games
  static const String gameResults = '$v1/games/results';
  static String gameWords(String categorySlug) => '$v1/games/words/$categorySlug';

  // Categories
  static const String categories = '$v1/categories';
  static String categoryWords(String slug) => '$v1/categories/$slug/words';

  // Coins
  static const String coinsBalance = '$v1/coins/balance';
  static const String coinsHistory = '$v1/coins/history';

  ApiConstants._();
}
