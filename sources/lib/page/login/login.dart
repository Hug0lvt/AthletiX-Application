import 'package:AthletiX/model/authentification/login/login.dart';
import 'package:AthletiX/model/authentification/login/loginResponse.dart';
import 'package:AthletiX/providers/api/clientApi.dart';
import 'package:AthletiX/providers/localstorage/secure/authKeys.dart';
import 'package:AthletiX/providers/localstorage/secure/authManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => LoginPage();
}

class LoginPage extends State<LoginForm> {

  final clientApi = getIt<ClientApi>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: SvgPicture.asset('assets/AthletiX.svg', width: width*0.8),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: Text("Non Implémanter"), // TODO mdp oublié
                      );
                    },
                  );
                },
                child: const Text(
                  'Forgot password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  verifyCerdentials();
                },
                child: Text('Log In'),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyCerdentials(){
    String email = emailController.value.text;
    String password = passwordController.value.text;

    if(email.isEmpty || password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email or password cannot be empty !'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    clientApi.authApiClient.login(Login(email: email, password: password))
        .then((loginResponse) {
          AuthManager.setToken(AuthKeys.ATH_BEARER_TOKEN_API.name, loginResponse.accessToken);
          AuthManager.setToken(AuthKeys.ATH_BEARER_REFRESH_TOKEN_API.name, loginResponse.refreshToken);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Connected !'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 5),
            ),
          );
          Navigator.pushNamed(context, '/home');
          return;
        })
        .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email or password is invalid !'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            ),
          );
          return;
        });



  }

}
