import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/services/api_client.dart';
import '../../../../shared/services/api_constants.dart';

final coinsRemoteDatasourceProvider = Provider<CoinsRemoteDatasource>((ref) {
  return CoinsRemoteDatasource(ref.watch(apiClientProvider));
});

class CoinsRemoteDatasource {
  final Dio _dio;

  const CoinsRemoteDatasource(this._dio);

  /// Returns the server-side coin balance, or null if unavailable.
  Future<int?> fetchBalance() async {
    try {
      final response =
          await _dio.get<dynamic>(ApiConstants.coinsBalance);
      final data = response.data;
      if (data is int) return data;
      if (data is Map) return data['balance'] as int?;
      return null;
    } on DioException {
      return null;
    }
  }
}
