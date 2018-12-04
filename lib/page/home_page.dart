import 'package:easy_drivers/container/group/group_list.dart';
import 'package:easy_drivers/model/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_drivers/container/drawer/drawer_container.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum NewGroup {create, add}

class HomePage extends StatelessWidget {

  final int drawerIndex = 0;

  Future<Null> _newGroup(BuildContext context) async {
    switch (await showDialog<NewGroup>(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            //contentPadding: EdgeInsets.symmetric(vertical: 10.0),
            titlePadding: EdgeInsets.all(20.0),
            title: const Text('New Group'),
            children: <Widget>[
              new SimpleDialogOption(
                onPressed: () { Navigator.pop(context, NewGroup.create); },
                child: const Text('Create a new one'),
              ),
              new SimpleDialogOption(
                onPressed: () { Navigator.pop(context, NewGroup.add); },
                child: const Text('Enter an existing group'),
              ),
            ],
          );
        }
    )) {
      case NewGroup.create:
        Navigator.pushNamed(context, '/create_group');
        break;
      case NewGroup.add:
        Navigator.pushNamed(context, '/add_group');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text("HomePage"),
          ),
          drawer: DrawerContainer(selectedIndex: drawerIndex,),
          body: GroupList(vm.user.uid),
          floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.add),
            tooltip: "New Group",
            onPressed: () => _newGroup(context),
          ),
        );
      }
    );
  }
}

class _ViewModel {
  final FirebaseUser user;

  _ViewModel({this.user});

  static _ViewModel fromStore(Store<AppState> store) {

    return new _ViewModel(
      user: store.state.firebaseUser,
    );

  }

}