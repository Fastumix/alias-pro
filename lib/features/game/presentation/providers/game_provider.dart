import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/constants.dart';
import '../../domain/entities/game.dart';
import '../../domain/entities/game_result.dart';
import '../../data/repositories/category_repository.dart';

final gameProvider = StateNotifierProvider<GameNotifier, Game?>(
  (ref) => GameNotifier(ref),
);

class GameNotifier extends StateNotifier<Game?> {
  final Ref _ref;

  GameNotifier(this._ref) : super(null);

  Future<void> startGame(String categoryId) async {
    final category = await _ref
        .read(categoryByIdProvider(categoryId).future);

    if (category == null) {
      throw Exception('Category not found');
    }

    state = Game.initial(
      categoryId: categoryId,
      words: category.words,
      duration: AppConstants.gameDurationSeconds,
    );
  }

  void guessWord() {
    if (state == null || !state!.isActive) return;

    final newScore = state!.score + AppConstants.pointsForCorrect;
    final updatedWords = List<String>.from(state!.usedWords)
      ..add(state!.currentWord);

    state = state!.copyWith(
      score: newScore,
      correctCount: state!.correctCount + 1,
      currentWordIndex: state!.currentWordIndex + 1,
      usedWords: updatedWords,
    );
  }

  void skipWord() {
    if (state == null || !state!.isActive) return;

    final newScore = (state!.score + AppConstants.pointsForSkip)
        .clamp(AppConstants.minimumScore, double.infinity)
        .toInt();
    final updatedWords = List<String>.from(state!.usedWords)
      ..add(state!.currentWord);

    state = state!.copyWith(
      score: newScore,
      skipCount: state!.skipCount + 1,
      currentWordIndex: state!.currentWordIndex + 1,
      usedWords: updatedWords,
    );
  }

  void updateTimeRemaining(int seconds) {
    if (state == null) return;
    state = state!.copyWith(timeRemaining: seconds);
  }

  void endGame() {
    if (state == null) return;
    state = state!.copyWith(isActive: false);
  }

  GameResult? getGameResult() {
    if (state == null) return null;

    return GameResult(
      categoryId: state!.categoryId,
      score: state!.score,
      correctCount: state!.correctCount,
      skipCount: state!.skipCount,
      playedAt: DateTime.now(),
    );
  }

  void resetGame() {
    state = null;
  }
}
