import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_constants.dart';

const _tokenKey = 'alias_pro_jwt';

final _secureStorage = FlutterSecureStorage(
  aOptions: const AndroidOptions(encryptedSharedPreferences: true),
);

// ── Token helpers ────────────────────────────────────────────────────────────

Future<String?> readToken() => _secureStorage.read(key: _tokenKey);
Future<void> writeToken(String token) =>
    _secureStorage.write(key: _tokenKey, value: token);
Future<void> deleteToken() => _secureStorage.delete(key: _tokenKey);

// ── Dio instance ─────────────────────────────────────────────────────────────

final apiClientProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // Attach JWT to every request that already has a token stored.
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await readToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) {
        // Surface the response body in the exception message when available.
        if (error.response != null) {
          final data = error.response!.data;
          final message = (data is Map ? data['message'] : null) ??
              error.message ??
              'Network error';
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              response: error.response,
              message: message.toString(),
              type: error.type,
            ),
          );
          return;
        }
        handler.next(error);
      },
    ),
  );

  return dio;
});
