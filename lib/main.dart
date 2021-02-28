import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'page/login_page.dart';
import 'page/main_page.dart';
import 'model/auth_model.dart';

/// Main method.
///
/// Perform asynchronous processing to initialize Firebase.
/// When executing asynchronous processing in the main method
/// Requires WidgetsFlutterBinding.ensureInitialized.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("TEST");
  await Firebase.initializeApp();
  runApp(LifelogApp());
}

/// LifelogApp class.
///
/// [StatelessWidget] inherit.
class LifelogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LifeLog',
        home: _LoginCheckPage(),
      ),
    );
  }
}

/// Login judgment class.
///
/// Determine login and go to the appropriate page.
/// [Dynamic] login:true:[MainPage] / login:false:[LoginForm]
class _LoginCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool _loggedIn = context.watch<AuthModel>().loggedIn;
    return _loggedIn ? MainPage() : LoginPage();
  }
}
