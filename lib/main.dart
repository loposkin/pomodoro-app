import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'state.dart';
import 'pomodoro_page.dart';
import 'reducers.dart';


void main() => runApp(ToDoListApp());

class ToDoListApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
  );

  @override
  Widget build(BuildContext context) => StoreProvider(
    store: this.store,
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PomodoroPage(),
    ),
  );
}