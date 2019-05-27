import 'dart:async';
import 'state.dart';
import 'package:redux/redux.dart';
import 'actions.dart';

class TimerState {
  Timer _timer;
  int _start;
  Store<AppState> store;


  TimerState( this._start, this.store);

  String getTime() => _start.toString();

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
            (timer) {
          if (_start < 1) {
            store.dispatch(StopPomodoroAction());
          } else {
            _start = _start - 1;
            store.dispatch(UpdateCounterAction(_start));
          }
        },
    );
    return this;
  }

  stopTimer() {
    this._timer.cancel();
  }
}