import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/entities/user_coins.dart';
import '../../data/datasources/coins_remote_datasource.dart';

final coinsProvider = StateNotifierProvider<CoinsNotifier, UserCoins>((ref) {
  return CoinsNotifier(ref.read(coinsRemoteDatasourceProvider));
});

class CoinsNotifier extends StateNotifier<UserCoins> {
  static const String _coinsKey = 'user_coins';
  final CoinsRemoteDatasource _remote;

  CoinsNotifier(this._remote)
      : super(UserCoins(balance: 0, lastUpdated: DateTime.now())) {
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
        await addCoins(100);
      }

      // Best-effort sync from backend — backend balance wins if available.
      final serverBalance = await _remote.fetchBalance();
      if (serverBalance != null && serverBalance != state.balance) {
        await setBalance(serverBalance);
      }
    } catch (e) {
      // ignore: avoid_print
    }
  }

  Future<void> _saveCoins() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(state.toJson());
      await prefs.setString(_coinsKey, jsonString);
    } catch (e) {
      // ignore: avoid_print
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
