import 'package:easy_drivers/container/group/group_list.dart';
import 'package:easy_drivers/model/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_drivers/container/drawer/drawer_container.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class HomePage extends StatelessWidget {

  final int drawerIndex = 0;

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
            body: GroupList(vm.user.uid)
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
      user: store.state.currentUser,
    );

  }

}