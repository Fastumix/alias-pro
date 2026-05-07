import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameSettings {
  final int timeRound;
  final int pointsForWin;
  final bool penaltyForMissing;
  final bool generalFinalWord;
  final bool soundEnabled;
  final String soundGuessed;
  final String soundPass;
  final String soundLastWord;
  final bool aiHelper;
  final bool specialRound;

  const GameSettings({
    this.timeRound = 60,
    this.pointsForWin = 60,
    this.penaltyForMissing = false,
    this.generalFinalWord = false,
    this.soundEnabled = true,
    this.soundGuessed = 'Bambino',
    this.soundPass = 'Trambon',
    this.soundLastWord = 'Hey Bro',
    this.aiHelper = false,
    this.specialRound = true,
  });

  GameSettings copyWith({
    int? timeRound,
    int? pointsForWin,
    bool? penaltyForMissing,
    bool? generalFinalWord,
    bool? soundEnabled,
    String? soundGuessed,
    String? soundPass,
    String? soundLastWord,
    bool? aiHelper,
    bool? specialRound,
  }) {
    return GameSettings(
      timeRound: timeRound ?? this.timeRound,
      pointsForWin: pointsForWin ?? this.pointsForWin,
      penaltyForMissing: penaltyForMissing ?? this.penaltyForMissing,
      generalFinalWord: generalFinalWord ?? this.generalFinalWord,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      soundGuessed: soundGuessed ?? this.soundGuessed,
      soundPass: soundPass ?? this.soundPass,
      soundLastWord: soundLastWord ?? this.soundLastWord,
      aiHelper: aiHelper ?? this.aiHelper,
      specialRound: specialRound ?? this.specialRound,
    );
  }
}

class GameSettingsNotifier extends StateNotifier<GameSettings> {
  GameSettingsNotifier() : super(const GameSettings());

  void setTimeRound(int seconds) =>
      state = state.copyWith(timeRound: seconds);

  void setPointsForWin(int points) =>
      state = state.copyWith(pointsForWin: points);

  void togglePenaltyForMissing() =>
      state = state.copyWith(penaltyForMissing: !state.penaltyForMissing);

  void toggleGeneralFinalWord() =>
      state = state.copyWith(generalFinalWord: !state.generalFinalWord);

  void toggleSound() =>
      state = state.copyWith(soundEnabled: !state.soundEnabled);

  void setSoundGuessed(String sound) =>
      state = state.copyWith(soundGuessed: sound);

  void setSoundPass(String sound) =>
      state = state.copyWith(soundPass: sound);

  void setSoundLastWord(String sound) =>
      state = state.copyWith(soundLastWord: sound);

  void toggleAiHelper() =>
      state = state.copyWith(aiHelper: !state.aiHelper);

  void toggleSpecialRound() =>
      state = state.copyWith(specialRound: !state.specialRound);
}

final gameSettingsProvider =
    StateNotifierProvider<GameSettingsNotifier, GameSettings>(
  (ref) => GameSettingsNotifier(),
);
