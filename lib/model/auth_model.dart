import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'google_auth_model.dart';

/// Auth model class.
///
/// This model is a provider that holds the authentication status of firebase.
class AuthModel extends ChangeNotifier {
  User _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // constructor
  AuthModel() {
    final User _currentUser = _auth.currentUser;

    print(_currentUser);
    // TODO 公式参照
    // You are logged in.
    if (_currentUser != null) {
      _user = _currentUser;
    }
  }

  /// Get user.
  ///
  /// [User] return current user.
  User get user => _user;

  /// get logg in status
  ///
  /// [bool] loggedIn : true LoggedOut : false
  bool get loggedIn => _user != null;

  /// Login process.
  ///
  /// [bool] login:true / logout:false
  Future<bool> login() async {
    try {
      UserCredential _userCredential = await _signInWithGoogle();
      _user = _userCredential.user;
      notifyListeners();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  /// Sign in with Google.
  ///
  /// [UserCredential]
  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount googleUser = await GoogleAuthModel().googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
