import 'dart:async';
class AppState {
  static final int pomodoroDuration = 1500;
  final int currentCounter;
  final bool pomoRunning;
  static Timer _timer = null;

  AppState(this.currentCounter, this.pomoRunning);

  static void setTimer(Timer timer) {
    _timer = timer;
  }

  factory AppState.initial() => AppState(0, false);
}
