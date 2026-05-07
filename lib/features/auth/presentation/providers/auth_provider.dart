import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/datasources/firebase_auth_datasource.dart';
import '../../data/datasources/backend_auth_datasource.dart';
import '../../../../shared/services/api_client.dart';

final authDatasourceProvider = Provider<FirebaseAuthDatasource>((ref) {
  return FirebaseAuthDatasource();
});

final authProvider = StreamProvider<User?>((ref) {
  final datasource = ref.watch(authDatasourceProvider);
  return datasource.authStateChanges;
});

final authNotifierProvider = Provider<AuthNotifier>((ref) {
  return AuthNotifier(
    ref.read(authDatasourceProvider),
    ref.read(backendAuthDatasourceProvider),
  );
});

class AuthNotifier {
  final FirebaseAuthDatasource _firebase;
  final BackendAuthDatasource _backend;

  AuthNotifier(this._firebase, this._backend);

  /// Signs in anonymously via Firebase, then exchanges the Firebase UID for
  /// an app JWT from the backend (best-effort — failure is non-fatal).
  Future<User?> signInAnonymously() async {
    final user = await _firebase.signInAnonymously();
    if (user != null) {
      await _exchangeFirebaseToken(user);
    }
    return user;
  }

  /// Call this after any Firebase sign-in to obtain and cache an app JWT.
  Future<void> _exchangeFirebaseToken(User user) async {
    final token = await _backend.loginWithFirebase(
      firebaseUid: user.uid,
      email: user.email,
    );
    if (token != null) {
      await writeToken(token);
    }
  }

  Future<void> signOut() async {
    await Future.wait([
      _firebase.signOut(),
      deleteToken(),
    ]);
  }

  User? getCurrentUser() => _firebase.currentUser;
}
