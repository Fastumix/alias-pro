class Game {
  final String categoryId;
  final List<String> words;
  final List<String> usedWords;
  final int currentWordIndex;
  final int score;
  final int correctCount;
  final int skipCount;
  final int timeRemaining;
  final bool isActive;

  const Game({
    required this.categoryId,
    required this.words,
    required this.usedWords,
    required this.currentWordIndex,
    required this.score,
    required this.correctCount,
    required this.skipCount,
    required this.timeRemaining,
    required this.isActive,
  });

  String get currentWord =>
      currentWordIndex < words.length ? words[currentWordIndex] : '';

  bool get hasMoreWords => currentWordIndex < words.length;

  Game copyWith({
    String? categoryId,
    List<String>? words,
    List<String>? usedWords,
    int? currentWordIndex,
    int? score,
    int? correctCount,
    int? skipCount,
    int? timeRemaining,
    bool? isActive,
  }) {
    return Game(
      categoryId: categoryId ?? this.categoryId,
      words: words ?? this.words,
      usedWords: usedWords ?? this.usedWords,
      currentWordIndex: currentWordIndex ?? this.currentWordIndex,
      score: score ?? this.score,
      correctCount: correctCount ?? this.correctCount,
      skipCount: skipCount ?? this.skipCount,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      isActive: isActive ?? this.isActive,
    );
  }

  factory Game.initial({
    required String categoryId,
    required List<String> words,
    required int duration,
  }) {
    return Game(
      categoryId: categoryId,
      words: words..shuffle(),
      usedWords: [],
      currentWordIndex: 0,
      score: 0,
      correctCount: 0,
      skipCount: 0,
      timeRemaining: duration,
      isActive: true,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Game &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          currentWordIndex == other.currentWordIndex &&
          score == other.score &&
          correctCount == other.correctCount &&
          skipCount == other.skipCount &&
          timeRemaining == other.timeRemaining &&
          isActive == other.isActive;

  @override
  int get hashCode =>
      categoryId.hashCode ^
      currentWordIndex.hashCode ^
      score.hashCode ^
      correctCount.hashCode ^
      skipCount.hashCode ^
      timeRemaining.hashCode ^
      isActive.hashCode;
}
