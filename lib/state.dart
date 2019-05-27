import 'timerState.dart';
class AppState {


  final int currentCounter;
  final bool pomoRunning;
  final TimerState timerState;

  AppState(this.currentCounter, this.pomoRunning, this.timerState);



  factory AppState.initial() => AppState(0, false, null);
}
