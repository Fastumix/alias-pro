import 'package:flutter_test/flutter_test.dart';
import 'package:alias_pro/features/game/domain/entities/category.dart';

void main() {
  group('Category Entity Tests', () {
    test('Category.fromJson creates category correctly', () {
      // Arrange
      final json = {
        'id': 'animals',
        'name': 'Тварини',
        'icon': '🦁',
        'words': ['Лев', 'Тигр', 'Слон'],
      };

      // Act
      final category = Category.fromJson(json);

      // Assert
      expect(category.id, 'animals');
      expect(category.name, 'Тварини');
      expect(category.icon, '🦁');
      expect(category.words.length, 3);
      expect(category.words, contains('Лев'));
      expect(category.words, contains('Тигр'));
      expect(category.words, contains('Слон'));
    });

    test('Category.toJson creates correct json', () {
      // Arrange
      const category = Category(
        id: 'movies',
        name: 'Фільми',
        icon: '🎬',
        words: ['Титанік', 'Аватар'],
      );

      // Act
      final json = category.toJson();

      // Assert
      expect(json['id'], 'movies');
      expect(json['name'], 'Фільми');
      expect(json['icon'], '🎬');
      expect(json['words'], isA<List<String>>());
      expect(json['words'].length, 2);
    });

    test('Category equality works correctly', () {
      // Arrange
      const category1 = Category(
        id: 'sport',
        name: 'Спорт',
        icon: '⚽',
        words: ['Футбол'],
      );
      const category2 = Category(
        id: 'sport',
        name: 'Спорт',
        icon: '⚽',
        words: ['Баскетбол'],
      );

      // Act & Assert
      expect(category1 == category2, true);
      expect(category1.hashCode == category2.hashCode, true);
    });

    test('Different categories are not equal', () {
      // Arrange
      const category1 = Category(
        id: 'sport',
        name: 'Спорт',
        icon: '⚽',
        words: ['Футбол'],
      );
      const category2 = Category(
        id: 'food',
        name: 'Їжа',
        icon: '🍕',
        words: ['Піца'],
      );

      // Act & Assert
      expect(category1 == category2, false);
    });

    test('Category words are immutable list', () {
      // Arrange
      const category = Category(
        id: 'test',
        name: 'Test',
        icon: '🎯',
        words: ['word1', 'word2'],
      );

      // Act & Assert
      expect(category.words, isA<List<String>>());
      expect(category.words.length, 2);
    });
  });
}
