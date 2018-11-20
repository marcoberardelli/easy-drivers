import 'package:easy_drivers/container/auth_button/login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:easy_drivers/action/auth_action.dart';
import 'package:easy_drivers/model/app_state.dart';
import 'package:redux/redux.dart';

class GoogleAuthButtonContainer extends StatelessWidget {
  GoogleAuthButtonContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Connect to the store:
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {

        return new LoginCard(
          icon: Icon(IconData(0xf1a0, fontFamily: 'custom',), size: 40.0,),
          text: Text(vm.buttonText),
          onPressed: vm.onPressedCallback,
        );
      },
    );
  }
}

class _ViewModel {
  final String buttonText;
  final Function onPressedCallback;

  _ViewModel({this.onPressedCallback, this.buttonText});

  static _ViewModel fromStore(Store<AppState> store) {
    // This is a bit of a more complex _viewModel
    // constructor. As the state updates, it will
    // recreate this _viewModel, and then pass
    // buttonText and the callback down to the button
    // with the appropriate qualities:
    //
    return new _ViewModel(
        buttonText:
        store.state.currentUser != null ? 'Log Out' : 'Log in with Google',
        onPressedCallback: () {
          if (store.state.currentUser != null) {
            store.dispatch(new LogOut());
          } else {
            store.dispatch(new LogIn());
          }
        });
  }
}