import 'package:easy_drivers/action/auth_action.dart';
import 'package:easy_drivers/model/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware() {

  final logIn = _createLogInMiddleware();
  final logOut = _createLogOutMiddleware();


  return []..add(new TypedMiddleware<AppState, LogIn>(logIn))..add( new TypedMiddleware<AppState, LogOut>(logOut));
}

Middleware<AppState> _createLogInMiddleware() {

  return (Store store, action, NextDispatcher next) async {

    FirebaseUser user;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final GoogleSignIn _googleSignIn = new GoogleSignIn();

    if (action is LogIn) {
      try {
        GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        user = await _auth.signInWithGoogle(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken
        );

        store.dispatch(new LogInSuccessful(user: user));
      } catch (error) {
        store.dispatch(LogInFail(error));
      }
    }
    next(action);
  };
}

Middleware<AppState> _createLogOutMiddleware() {

  return (Store store, action, NextDispatcher next) async {

    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.signOut();
      store.dispatch(new LogOutSuccessful());
    } catch (error) {
      print(error);
    }

    next(action);
  };
}