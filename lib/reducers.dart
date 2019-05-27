import 'package:redux/redux.dart';
import 'state.dart';
import 'actions.dart';
import 'dart:developer';
import 'timerState.dart';
import 'package:flutter/foundation.dart';
AppState appReducer(AppState state, action) => AppState(counterReducer(state.currentCounter, action),
    runningReducer(state.pomoRunning, action), timerStateReducer(state.timerState, action));

final Reducer<int> counterReducer = combineReducers([
  TypedReducer<int, UpdateCounterAction>(_updateCounterReducer),
]);

int _updateCounterReducer(int oldCounter, UpdateCounterAction action) => action.newCounter;

final Reducer<bool> runningReducer = combineReducers([
  TypedReducer<bool, StopPomodoroAction>(_stopPomodoroReducer),
  TypedReducer<bool, StartPomodoroAction>(_startPomodoroReducer),
]);

bool _stopPomodoroReducer(bool oldValue, StopPomodoroAction action) => false;
bool _startPomodoroReducer(bool oldValue, StartPomodoroAction action) => true;

final Reducer<TimerState> timerStateReducer = combineReducers([
  TypedReducer<TimerState, StopPomodoroAction>(_stopTimerReducer),
  TypedReducer<TimerState, StartPomodoroAction>(_startTimerReducer),
]);

TimerState _stopTimerReducer(TimerState timer, StopPomodoroAction action) {
  timer.stopTimer();
  return null;
}

TimerState _startTimerReducer(TimerState timer, StartPomodoroAction action) {
  return action.timerState.startTimer();
}