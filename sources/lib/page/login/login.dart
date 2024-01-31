import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: dotenv.env['CLI_ID'],
    scopes: ['email', 'profile', 'openid'],
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child : Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/AthletiX.svg', width: width*0.8),
                SizedBox(height: 350),
                SignInButton(
                  Buttons.Google,
                  onPressed: () async {
                    await _handleGoogleSignIn(context);
                  },
                ),
                const Divider(),
                SignInButton(
                  Buttons.Apple,
                  onPressed: () async {
                    await _handleGoogleSignIn(context);
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      if (_googleSignIn.currentUser != null) {
        GoogleSignInAuthentication googleSignInAuthentication = await _googleSignIn.currentUser!.authentication;
        print(googleSignInAuthentication.idToken);
        print(_googleSignIn.currentUser!.id);
      }
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      print('Error during Google sign in: $error');
    }
  }
}