import 'package:redux/redux.dart';
import 'state.dart';
import 'actions.dart';

AppState appReducer(AppState state, action) => AppState(counterReducer(state.currentCounter, action),
    runningReducer(state.pomoRunning, action));

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

