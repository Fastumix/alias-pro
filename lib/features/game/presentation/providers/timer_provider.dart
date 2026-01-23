import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/constants.dart';

final timerProvider = StateNotifierProvider.autoDispose<TimerNotifier, int>(
  (ref) => TimerNotifier(),
);

class TimerNotifier extends StateNotifier<int> {
  Timer? _timer;
  final List<void Function()> _onCompleteCallbacks = [];

  TimerNotifier() : super(AppConstants.gameDurationSeconds);

  void startTimer({required void Function() onComplete}) {
    _onCompleteCallbacks.add(onComplete);
    
    _timer?.cancel();
    state = AppConstants.gameDurationSeconds;

    _timer = Timer.periodic(
      AppConstants.timerUpdateInterval,
      (timer) {
        if (state > 0) {
          state = state - 1;
        } else {
          stopTimer();
          _notifyCompletion();
        }
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void resetTimer() {
    stopTimer();
    state = AppConstants.gameDurationSeconds;
    _onCompleteCallbacks.clear();
  }

  void _notifyCompletion() {
    for (final callback in _onCompleteCallbacks) {
      callback();
    }
    _onCompleteCallbacks.clear();
  }

  @override
  void dispose() {
    stopTimer();
    _onCompleteCallbacks.clear();
    super.dispose();
  }
}
