import 'package:flutter_test/flutter_test.dart';
import 'package:alias_pro/features/game/domain/entities/game.dart';
import 'package:alias_pro/config/constants.dart';

void main() {
  group('Game Entity Tests', () {
    test('Game.initial creates game with correct initial state', () {
      // Arrange
      const categoryId = 'test_category';
      final words = ['word1', 'word2', 'word3'];
      const duration = 90;

      // Act
      final game = Game.initial(
        categoryId: categoryId,
        words: words,
        duration: duration,
      );

      // Assert
      expect(game.categoryId, categoryId);
      expect(game.words.length, words.length);
      expect(game.currentWordIndex, 0);
      expect(game.score, 0);
      expect(game.correctCount, 0);
      expect(game.skipCount, 0);
      expect(game.timeRemaining, duration);
      expect(game.isActive, true);
      expect(game.usedWords, isEmpty);
    });

    test('currentWord returns correct word at current index', () {
      // Arrange
      final words = ['word1', 'word2', 'word3'];
      final game = Game.initial(
        categoryId: 'test',
        words: words,
        duration: 90,
      );

      // Act & Assert
      expect(game.currentWord, isNotEmpty);
      expect(words.contains(game.currentWord), true);
    });

    test('hasMoreWords returns true when words remain', () {
      // Arrange
      final game = Game.initial(
        categoryId: 'test',
        words: ['word1', 'word2'],
        duration: 90,
      );

      // Act & Assert
      expect(game.hasMoreWords, true);
    });

    test('hasMoreWords returns false when all words used', () {
      // Arrange
      final game = Game.initial(
        categoryId: 'test',
        words: ['word1'],
        duration: 90,
      ).copyWith(currentWordIndex: 1);

      // Act & Assert
      expect(game.hasMoreWords, false);
    });

    test('copyWith creates new game with updated values', () {
      // Arrange
      final original = Game.initial(
        categoryId: 'test',
        words: ['word1', 'word2'],
        duration: 90,
      );

      // Act
      final updated = original.copyWith(
        score: 10,
        correctCount: 5,
        skipCount: 2,
      );

      // Assert
      expect(updated.score, 10);
      expect(updated.correctCount, 5);
      expect(updated.skipCount, 2);
      expect(updated.categoryId, original.categoryId);
      expect(updated.timeRemaining, original.timeRemaining);
    });

    test('equality works correctly', () {
      // Arrange
      final game1 = Game.initial(
        categoryId: 'test',
        words: ['word1'],
        duration: 90,
      );
      final game2 = Game.initial(
        categoryId: 'test',
        words: ['word1'],
        duration: 90,
      );

      // Act & Assert
      expect(game1 == game2, true);
      expect(game1.hashCode == game2.hashCode, true);
    });
  });

  group('Game Score Logic Tests', () {
    test('score increases by correct amount on guess', () {
      // Arrange
      final game = Game.initial(
        categoryId: 'test',
        words: ['word1'],
        duration: 90,
      );

      // Act
      final updatedGame = game.copyWith(
        score: game.score + AppConstants.pointsForCorrect,
        correctCount: game.correctCount + 1,
        currentWordIndex: game.currentWordIndex + 1,
      );

      // Assert
      expect(updatedGame.score, AppConstants.pointsForCorrect);
      expect(updatedGame.correctCount, 1);
    });

    test('score decreases correctly on skip with minimum bound', () {
      // Arrange
      final game = Game.initial(
        categoryId: 'test',
        words: ['word1'],
        duration: 90,
      );

      // Act
      final newScore = (game.score + AppConstants.pointsForSkip)
          .clamp(AppConstants.minimumScore, double.infinity)
          .toInt();
      final updatedGame = game.copyWith(
        score: newScore,
        skipCount: game.skipCount + 1,
        currentWordIndex: game.currentWordIndex + 1,
      );

      // Assert
      expect(updatedGame.score, AppConstants.minimumScore);
      expect(updatedGame.skipCount, 1);
    });

    test('score never goes below minimum', () {
      // Arrange
      final game = Game.initial(
        categoryId: 'test',
        words: ['word1', 'word2', 'word3'],
        duration: 90,
      ).copyWith(score: 0);

      // Act
      final newScore = (game.score + AppConstants.pointsForSkip)
          .clamp(AppConstants.minimumScore, double.infinity)
          .toInt();

      // Assert
      expect(newScore, greaterThanOrEqualTo(AppConstants.minimumScore));
    });
  });
}
