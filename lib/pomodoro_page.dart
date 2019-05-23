import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'actions.dart';
import 'state.dart';

class ToDoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) =>
            Scaffold(
              appBar: AppBar(
                title: Text(viewModel.pageTitle),
              ),
              body: Center(child: IconButton(icon: Icon(Icons.play_circle_filled), onPressed: null),)

            ),
      );
  Widget _createWidget(_PomoViewModel item) {
    if (item is _RunningPomoViewModel) {
      return _createRunningPomoWidget(item);
    } else {
      return _createPomoWidget(item);
    }
  }

  Widget _createRunningPomoWidget(_PomoViewModel item) {

  }

  Widget _createPomoWidget(_PomoViewModel item) {

  }

}

class _ViewModel {
  final String pageTitle;
  final List<_ItemViewModel> items;
  final Function() onAddItem;
  final String newItemToolTip;
  final IconData newItemIcon;

  _ViewModel(this.pageTitle, this.items, this.onAddItem, this.newItemToolTip, this.newItemIcon);

  factory _ViewModel.create(Store<AppState> store) {
    List<_ItemViewModel> items = store.state.toDos
        .map((ToDoItem item) => _ToDoItemViewModel(item.title, () {
      store.dispatch(RemoveItemAction(item));
      store.dispatch(SaveListAction());
    }, 'Delete', Icons.delete) as _ItemViewModel)
        .toList();

    if (store.state.listState == ListState.listWithNewItem) {
      items.add(_EmptyItemViewModel('Type the next task here', (String title) {
        store.dispatch(DisplayListOnlyAction());
        store.dispatch(AddItemAction(ToDoItem(title)));
        store.dispatch(SaveListAction());
      }, 'Add'));
    }

    return _ViewModel('To Do', items, () => store.dispatch(DisplayListWithNewItemAction()), 'Add new to-do item', Icons.add);
  }
}

abstract class _PomoViewModel {}

@immutable
class _RunningPomoViewModel extends _PomoViewModel {
  final String hint;
  final Function(String) onStopPomo;
  final String time;
  _RunningPomoViewModel(this.hint, this.onStopPomo, this.time);
}

@immutable
class _StoppedPomoViewModel extends _PomoViewModel {
  final String hint;
  final Function(String) onStartPomo;

  _StoppedPomoViewModel(this.hint, this.onStartPomo);
}