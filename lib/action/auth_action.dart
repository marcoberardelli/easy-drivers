import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LogIn{}

class LogInSuccessful{
  final FirebaseUser user;

  LogInSuccessful({@required this.user});

}

class LogInFail{
  final dynamic error;

  LogInFail(this.error);
}

class LogOut{}

class LogOutSuccessful{
  LogOutSuccessful();
}