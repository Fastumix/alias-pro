import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/services/api_client.dart';
import '../../../../shared/services/api_constants.dart';

final backendAuthDatasourceProvider = Provider<BackendAuthDatasource>((ref) {
  return BackendAuthDatasource(ref.watch(apiClientProvider));
});

class BackendAuthDatasource {
  final Dio _dio;

  const BackendAuthDatasource(this._dio);

  /// Exchange a Firebase UID (and optional email) for an app JWT.
  /// Returns the access token string, or null if the backend is unreachable.
  Future<String?> loginWithFirebase({
    required String firebaseUid,
    String? email,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.authFirebase,
        data: {
          'firebaseUid': firebaseUid,
          if (email != null) 'email': email,
        },
      );
      return response.data?['accessToken'] as String?;
    } on DioException {
      // Backend unavailable — app continues without a JWT.
      return null;
    }
  }

  Future<Map<String, dynamic>?> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiConstants.authRegister,
      data: {
        'email': email,
        'password': password,
        'displayName': displayName,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiConstants.authLogin,
      data: {'email': email, 'password': password},
    );
    return response.data;
  }
}
