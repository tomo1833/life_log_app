import 'package:google_sign_in/google_sign_in.dart';

/// Google Auth Model Class.
///
/// This class signs in to google to get an account.
class GoogleAuthModel {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/contacts.readonly',
    'https://www.googleapis.com/auth/calendar.events',
  ]);
}
