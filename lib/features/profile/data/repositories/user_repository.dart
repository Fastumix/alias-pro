import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return UserRepository(firestore);
});

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository(this._firestore);

  /// Create or update user profile
  Future<void> saveUserProfile({
    required String uid,
    String? nickname,
    int? totalGames,
    Map<String, int>? bestScores,
  }) async {
    try {
      final userDoc = _firestore.collection('users').doc(uid);
      
      final data = <String, dynamic>{
        'uid': uid,
        'lastUpdated': FieldValue.serverTimestamp(),
      };
      
      if (nickname != null) data['nickname'] = nickname;
      if (totalGames != null) data['totalGames'] = totalGames;
      if (bestScores != null) data['bestScores'] = bestScores;
      
      await userDoc.set(
        data,
        SetOptions(merge: true),
      );
    } catch (e) {
      throw Exception('Failed to save user profile: $e');
    }
  }

  /// Get user profile
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.exists ? doc.data() : null;
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  /// Update best score for category
  Future<void> updateBestScore({
    required String uid,
    required String categoryId,
    required int score,
  }) async {
    try {
      final userDoc = _firestore.collection('users').doc(uid);
      
      await userDoc.set({
        'bestScores.$categoryId': score,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true),);
    } catch (e) {
      throw Exception('Failed to update best score: $e');
    }
  }

  /// Increment total games played
  Future<void> incrementTotalGames(String uid) async {
    try {
      final userDoc = _firestore.collection('users').doc(uid);
      
      await userDoc.set({
        'totalGames': FieldValue.increment(1),
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true),);
    } catch (e) {
      throw Exception('Failed to increment total games: $e');
    }
  }
}
