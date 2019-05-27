import 'timerState.dart';

class StartPomodoroAction {
  final TimerState timerState;

  StartPomodoroAction(this.timerState);
}

class StopPomodoroAction {

}



class UpdateCounterAction {
  final int newCounter;

  UpdateCounterAction(this.newCounter);
}