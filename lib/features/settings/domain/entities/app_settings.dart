class AppSettings {
  final String userName;
  final String? avatarUrl;
  final String language;
  final bool soundEnabled;
  final bool vibrationEnabled;

  const AppSettings({
    this.userName = 'Гравець',
    this.avatarUrl,
    this.language = 'uk',
    this.soundEnabled = true,
    this.vibrationEnabled = true,
  });

  AppSettings copyWith({
    String? userName,
    String? avatarUrl,
    String? language,
    bool? soundEnabled,
    bool? vibrationEnabled,
  }) {
    return AppSettings(
      userName: userName ?? this.userName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      language: language ?? this.language,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'avatarUrl': avatarUrl,
      'language': language,
      'soundEnabled': soundEnabled,
      'vibrationEnabled': vibrationEnabled,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      userName: json['userName'] as String? ?? 'Гравець',
      avatarUrl: json['avatarUrl'] as String?,
      language: json['language'] as String? ?? 'uk',
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      vibrationEnabled: json['vibrationEnabled'] as bool? ?? true,
    );
  }
}
