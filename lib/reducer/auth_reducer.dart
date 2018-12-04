import 'package:easy_drivers/action/auth_action.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';


final firebaseReducer = combineReducers<FirebaseUser>([
  new TypedReducer<FirebaseUser, LogInFirebase>(_logInFirebase),
  new TypedReducer<FirebaseUser, LogOutSuccessful>(_logOutFirebase)
]);

FirebaseUser _logInFirebase(FirebaseUser user, action) {
  return action.user;
}

Null _logOutFirebase(FirebaseUser user, action) {
  return null;
}

final googleReducer = combineReducers<GoogleSignIn>([
  new TypedReducer<GoogleSignIn, LogInGoogle>(_logInGoogle),
  new TypedReducer<GoogleSignIn, LogOutSuccessful>(_logOutGoogle)
]);

GoogleSignIn _logInGoogle(GoogleSignIn googleSignIn, action) {
  return action.googleSignIn;
}


Null _logOutGoogle(GoogleSignIn googleSignIn, action) {
  _logOut(googleSignIn);
  return null;
}
void _logOut(GoogleSignIn googleSignIn) async {
  await googleSignIn.signOut();
}