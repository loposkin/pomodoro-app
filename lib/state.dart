class AppState {
  final int pomodoroDuration;
  final int currentCounter;
  final bool pomoRunning;

  AppState(this.pomodoroDuration, this.currentCounter, this.pomoRunning);

  factory AppState.initial() => AppState(1500, 0, false);
}
