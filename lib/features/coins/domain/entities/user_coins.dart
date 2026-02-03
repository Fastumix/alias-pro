class UserCoins {
  final int balance;
  final DateTime lastUpdated;

  const UserCoins({
    required this.balance,
    required this.lastUpdated,
  });

  UserCoins copyWith({
    int? balance,
    DateTime? lastUpdated,
  }) {
    return UserCoins(
      balance: balance ?? this.balance,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory UserCoins.fromJson(Map<String, dynamic> json) {
    return UserCoins(
      balance: json['balance'] as int? ?? 0,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }
}
