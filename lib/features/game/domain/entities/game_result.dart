class GameResult {
  final String categoryId;
  final int score;
  final int correctCount;
  final int skipCount;
  final DateTime playedAt;

  const GameResult({
    required this.categoryId,
    required this.score,
    required this.correctCount,
    required this.skipCount,
    required this.playedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'score': score,
      'correctCount': correctCount,
      'skipCount': skipCount,
      'playedAt': playedAt.toIso8601String(),
    };
  }

  factory GameResult.fromJson(Map<String, dynamic> json) {
    return GameResult(
      categoryId: json['categoryId'] as String,
      score: json['score'] as int,
      correctCount: json['correctCount'] as int,
      skipCount: json['skipCount'] as int,
      playedAt: DateTime.parse(json['playedAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameResult &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          score == other.score &&
          correctCount == other.correctCount &&
          skipCount == other.skipCount &&
          playedAt == other.playedAt;

  @override
  int get hashCode =>
      categoryId.hashCode ^
      score.hashCode ^
      correctCount.hashCode ^
      skipCount.hashCode ^
      playedAt.hashCode;
}
