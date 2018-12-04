
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppState {

  final bool isLoading;
  final FirebaseUser firebaseUser;
  final GoogleSignIn googleSignIn;

  AppState({this.isLoading = false, this.firebaseUser, this.googleSignIn});

  AppState copyWith({bool isLoading}) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      firebaseUser: firebaseUser ?? this.firebaseUser,
      googleSignIn: googleSignIn ?? this.googleSignIn
    );
  }
}