import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'actions.dart';
import 'state.dart';
import 'timerState.dart';

class PomodoroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => _createWidget(viewModel, context),
      );


  Widget _createWidget(_ViewModel viewModel, context) {
    Widget result = Scaffold(
      body: new Center(
        child: viewModel.running ? _createRunningPomoWidget(viewModel, context)
          : _createPomoWidget(viewModel, context),
      ),
    );
    return result;
  }

  Widget _createRunningPomoWidget(_ViewModel viewModel, context) {
    double size = MediaQuery.of(context).size.width * 0.75;
    return Column(children: <Widget>[IconButton(icon: Icon(Icons.stop, color: Colors.red,), iconSize: size, onPressed: viewModel.onStop),
      Text(viewModel.timer,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))],
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,);
  }

  Widget _createPomoWidget(_ViewModel viewModel, context) {
    double size = MediaQuery.of(context).size.width * 0.75;
    return Column(children: <Widget>[IconButton(icon: Icon(Icons.play_circle_filled, color: Colors.red,), iconSize: size, onPressed: viewModel.onStart),
      Text("Tap to start",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))],
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,);
  }

}

class _ViewModel {
  final String timer;
  final bool running;
  final Function onStart;
  final Function onStop;
  _ViewModel(this.running, this.timer, this.onStart, this.onStop);

  static String counterToString(int counter) {
    String result = "";
    if(counter ~/ 60 < 10) {
      result += "0";
    }
    result += "${counter ~/ 60}:";
    if(counter % 60 < 10) {
      result += "0";
    }
    result += "${counter % 60}";
    return result;
  }

  factory _ViewModel.create(Store<AppState> store) {


    const duration = 1500;
    return _ViewModel(store.state.pomoRunning, 
        counterToString(store.state.currentCounter),
        () {
          store.dispatch(UpdateCounterAction(duration));
          store.dispatch(StartPomodoroAction(new TimerState(duration, store)));

        },
        () {
          store.dispatch(StopPomodoroAction());
        });
    }
}


