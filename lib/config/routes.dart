import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/game/presentation/screens/home_screen.dart';
import '../features/game/presentation/screens/start_screen.dart';
import '../features/game/presentation/screens/categories_screen.dart';
import '../features/game/presentation/screens/game_screen.dart';
import '../features/game/presentation/screens/result_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/settings/presentation/screens/profile_edit_screen.dart';
import '../features/settings/presentation/screens/language_screen.dart';
import '../features/settings/presentation/screens/how_to_play_screen.dart';
import '../features/auth/presentation/providers/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'start',
        builder: (context, state) => const StartScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/categories',
        name: 'categories',
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: '/game/:categoryId',
        name: 'game',
        builder: (context, state) {
          final categoryId = state.pathParameters['categoryId']!;
          return GameScreen(categoryId: categoryId);
        },
      ),
      GoRoute(
        path: '/result',
        name: 'result',
        builder: (context, state) => const ResultScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/settings/profile',
        name: 'settings-profile',
        builder: (context, state) => const ProfileEditScreen(),
      ),
      GoRoute(
        path: '/settings/language',
        name: 'settings-language',
        builder: (context, state) => const LanguageScreen(),
      ),
      GoRoute(
        path: '/settings/how-to-play',
        name: 'settings-how-to-play',
        builder: (context, state) => const HowToPlayScreen(),
      ),
    ],
    redirect: (context, state) async {
      // Only redirect if not on start screen
      if (state.matchedLocation == '/') {
        return null;
      }
      
      final authState = ref.read(authProvider);
      
      // Initialize anonymous auth if not authenticated
      if (authState.value == null) {
        await ref.read(authNotifierProvider).signInAnonymously();
      }
      
      return null;
    },
  );
});
