import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/datasources/firebase_auth_datasource.dart';

final authDatasourceProvider = Provider<FirebaseAuthDatasource>((ref) {
  return FirebaseAuthDatasource();
});

final authProvider = StreamProvider<User?>((ref) {
  final datasource = ref.watch(authDatasourceProvider);
  return datasource.authStateChanges;
});

final authNotifierProvider = Provider<AuthNotifier>((ref) {
  return AuthNotifier(ref.read(authDatasourceProvider));
});

class AuthNotifier {
  final FirebaseAuthDatasource _datasource;

  AuthNotifier(this._datasource);

  Future<User?> signInAnonymously() async {
    return await _datasource.signInAnonymously();
  }

  Future<void> signOut() async {
    await _datasource.signOut();
  }

  User? getCurrentUser() {
    return _datasource.currentUser;
  }
}
