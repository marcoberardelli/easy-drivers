import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:easy_drivers/action/auth_action.dart';
import 'package:easy_drivers/model/app_state.dart';


class DrawerContainer extends StatelessWidget {

  final int selectedIndex;

  DrawerContainer({this.selectedIndex});


  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm){
        return Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(vm.user.displayName),
                accountEmail: Text(vm.user.email),
                currentAccountPicture: Image.network(vm.user.photoUrl),
              ),
              ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home),
                selected: 0 == selectedIndex,
                onTap: null,
              ),
              ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings_applications),
                selected: 1 == selectedIndex,
                onTap: null,
              ),
              Divider(
                color: Colors.black54,
                height: 30,
              ),
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.exit_to_app),
                onTap: (){
                  Navigator.pop(context);
                  vm.onLogout();
                }
              ),
              Divider(
                color: Colors.black54,
                height: 30,
              ),
              ListTile(
                title: Text("Info"),
                leading: Icon(Icons.info_outline),
                onTap: null,
              )
            ]
          ),
        );
      },
    );
  }

}


class _ViewModel {
  final FirebaseUser user;
  final Function onLogout;

  _ViewModel({this.user, this.onLogout});

  static _ViewModel fromStore(Store<AppState> store) {

    return new _ViewModel(
      user: store.state.currentUser,
      onLogout: () => store.dispatch(LogOut()),
    );

  }
}