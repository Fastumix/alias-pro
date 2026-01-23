import 'package:flutter_test/flutter_test.dart';
import 'package:alias_pro/features/game/domain/entities/game_result.dart';

void main() {
  group('GameResult Entity Tests', () {
    test('GameResult.toJson creates correct json', () {
      // Arrange
      final playedAt = DateTime(2026, 1, 23, 12, 0, 0);
      final result = GameResult(
        categoryId: 'animals',
        score: 15,
        correctCount: 20,
        skipCount: 5,
        playedAt: playedAt,
      );

      // Act
      final json = result.toJson();

      // Assert
      expect(json['categoryId'], 'animals');
      expect(json['score'], 15);
      expect(json['correctCount'], 20);
      expect(json['skipCount'], 5);
      expect(json['playedAt'], playedAt.toIso8601String());
    });

    test('GameResult.fromJson creates result correctly', () {
      // Arrange
      final playedAt = DateTime(2026, 1, 23, 12, 0, 0);
      final json = {
        'categoryId': 'movies',
        'score': 25,
        'correctCount': 30,
        'skipCount': 5,
        'playedAt': playedAt.toIso8601String(),
      };

      // Act
      final result = GameResult.fromJson(json);

      // Assert
      expect(result.categoryId, 'movies');
      expect(result.score, 25);
      expect(result.correctCount, 30);
      expect(result.skipCount, 5);
      expect(result.playedAt, playedAt);
    });

    test('GameResult equality works correctly', () {
      // Arrange
      final playedAt = DateTime(2026, 1, 23, 12, 0, 0);
      final result1 = GameResult(
        categoryId: 'sport',
        score: 10,
        correctCount: 15,
        skipCount: 5,
        playedAt: playedAt,
      );
      final result2 = GameResult(
        categoryId: 'sport',
        score: 10,
        correctCount: 15,
        skipCount: 5,
        playedAt: playedAt,
      );

      // Act & Assert
      expect(result1 == result2, true);
      expect(result1.hashCode == result2.hashCode, true);
    });

    test('Different results are not equal', () {
      // Arrange
      final playedAt = DateTime(2026, 1, 23, 12, 0, 0);
      final result1 = GameResult(
        categoryId: 'sport',
        score: 10,
        correctCount: 15,
        skipCount: 5,
        playedAt: playedAt,
      );
      final result2 = GameResult(
        categoryId: 'food',
        score: 20,
        correctCount: 25,
        skipCount: 5,
        playedAt: playedAt,
      );

      // Act & Assert
      expect(result1 == result2, false);
    });

    test('GameResult serialization roundtrip works', () {
      // Arrange
      final original = GameResult(
        categoryId: 'history',
        score: 30,
        correctCount: 35,
        skipCount: 5,
        playedAt: DateTime.now(),
      );

      // Act
      final json = original.toJson();
      final restored = GameResult.fromJson(json);

      // Assert
      expect(restored.categoryId, original.categoryId);
      expect(restored.score, original.score);
      expect(restored.correctCount, original.correctCount);
      expect(restored.skipCount, original.skipCount);
      expect(
        restored.playedAt.toIso8601String(),
        original.playedAt.toIso8601String(),
      );
    });
  });
}
