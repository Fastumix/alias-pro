import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/services/api_client.dart';
import '../../../../shared/services/api_constants.dart';
import '../../domain/entities/game_result.dart';

final gameResultsRemoteDatasourceProvider =
    Provider<GameResultsRemoteDatasource>((ref) {
  return GameResultsRemoteDatasource(ref.watch(apiClientProvider));
});

class GameResultsRemoteDatasource {
  final Dio _dio;

  const GameResultsRemoteDatasource(this._dio);

  /// Posts a completed game round result to the backend.
  /// Silently swallows network errors so offline play is unaffected.
  Future<void> saveResult({
    required GameResult result,
    required String teamName,
    required int round,
    required int timeRound,
  }) async {
    try {
      await _dio.post<void>(
        ApiConstants.gameResults,
        data: {
          'categorySlug': result.categoryId,
          'teamName': teamName,
          'round': round,
          'score': result.score,
          'correctCount': result.correctCount,
          'skipCount': result.skipCount,
          'timeRound': timeRound,
        },
      );
    } on DioException {
      // Non-fatal: local result is already saved.
    }
  }
}
