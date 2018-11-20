import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:easy_drivers/page/home_page.dart';
import 'package:easy_drivers/page/login_page.dart';
import 'package:easy_drivers/model/app_state.dart';

class RootPage extends StatelessWidget {

  RootPage();

  @override
  Widget build(BuildContext context) {

    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return vm.user != null ? HomePage() : LoginPage();
      },
    );
  }
}


class _ViewModel {

  final FirebaseUser user;

  _ViewModel({this.user});

  static _ViewModel fromStore(Store<AppState> store) {
    // This is a bit of a more complex _viewModel
    // constructor. As the state updates, it will
    // recreate this _viewModel, and then pass
    // buttonText and the callback down to the button
    // with the appropriate qualities:
    //
    return new _ViewModel(
          user: store.state.currentUser
        );
  }
}