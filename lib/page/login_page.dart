import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/auth_model.dart';

/// Login page class.
///
/// This is the screen to log in when you are not logged in.
/// [StatelessWidget] Inherits
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5faf0),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.49, -0.53),
                end: Alignment(-0.96, 0.99),
                colors: [const Color(0xff6f9676), const Color(0xff546e53)],
                stops: [0.0, 1.0],
              ),
            ),

            // Logo
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Image.asset(
                          'assets/images/images.png',
                          width: 36,
                          height: 40,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          'Life Log',
                          style: TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 46,
                            color: const Color(0xffffffff),
                            letterSpacing: -0.92,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // message
                Container(
                  padding: EdgeInsets.only(top: 30, bottom: 170),
                  child: Text(
                    'ワンタッチで日々を記録しよう',
                    style: TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 14,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                // button
                InkWell(
                  onTap: () async {
                    print("TEST001");
                    await _loginAction(context);
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            width: 38,
                            height: 26,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: const AssetImage(
                                    'assets/images/google.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontFamily: 'Noto Sans',
                              fontSize: 15,
                              color: const Color(0xff000000),
                              letterSpacing: -0.3,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Login Action.
  ///
  /// [BuildContext] Input context.
  /// [bool] Login:true / login:false
  Future<bool> _loginAction(BuildContext context) async {
    print("_loginAction START");
    bool loggedIn = false;
    if (await context.read<AuthModel>().login()) {
      loggedIn = true;
    }
    return loggedIn;
  }
}
