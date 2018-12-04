import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogIn{}

class LogInFirebase{
  final FirebaseUser user;

  LogInFirebase({@required this.user});

}

class LogInGoogle{
  final GoogleSignIn googleSignIn;
  LogInGoogle({@required this.googleSignIn});
}

class LogInFail{
  final dynamic error;

  LogInFail(this.error);
}

class LogOut{}

class LogOutSuccessful{
  LogOutSuccessful();
}