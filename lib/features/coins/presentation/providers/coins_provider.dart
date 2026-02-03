import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/entities/user_coins.dart';

final coinsProvider = StateNotifierProvider<CoinsNotifier, UserCoins>((ref) {
  return CoinsNotifier();
});

class CoinsNotifier extends StateNotifier<UserCoins> {
  static const String _coinsKey = 'user_coins';

  CoinsNotifier() : super(UserCoins(balance: 0, lastUpdated: DateTime.now())) {
    _loadCoins();
  }

  Future<void> _loadCoins() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_coinsKey);
      
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        state = UserCoins.fromJson(json);
      } else {
        // Початковий баланс для нових користувачів
        await addCoins(100);
      }
    } catch (e) {
      print('Error loading coins: $e');
    }
  }

  Future<void> _saveCoins() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(state.toJson());
      await prefs.setString(_coinsKey, jsonString);
    } catch (e) {
      print('Error saving coins: $e');
    }
  }

  Future<void> addCoins(int amount) async {
    state = state.copyWith(
      balance: state.balance + amount,
      lastUpdated: DateTime.now(),
    );
    await _saveCoins();
  }

  Future<bool> spendCoins(int amount) async {
    if (state.balance >= amount) {
      state = state.copyWith(
        balance: state.balance - amount,
        lastUpdated: DateTime.now(),
      );
      await _saveCoins();
      return true;
    }
    return false;
  }

  Future<void> setBalance(int balance) async {
    state = state.copyWith(
      balance: balance,
      lastUpdated: DateTime.now(),
    );
    await _saveCoins();
  }
}
