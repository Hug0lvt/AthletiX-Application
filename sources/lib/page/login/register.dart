import 'package:AthletiX/model/authentification/register.dart';
import 'package:AthletiX/model/profile.dart';
import 'package:AthletiX/providers/localstorage/secure/authManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';
import '../../model/authentification/login/login.dart';
import '../../providers/api/clientApi.dart';
import '../../providers/localstorage/secure/authKeys.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});
  @override
  State<RegisterForm> createState() => RegisterPage();
}

class RegisterPage extends State<RegisterForm> {

  final clientApi = getIt<ClientApi>();

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm password',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  register();
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    String email = emailController.value.text;
    String username = usernameController.value.text;
    String password = passwordController.value.text;
    String confirmPassword = confirmPasswordController.value.text;

    if ([email, username, password, confirmPassword].any((element) => element.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('At least one of the fields is empty!'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    try {
      await clientApi.authClientApi.register(Register(email: email, password: password));
      final loginResponse = await clientApi.authClientApi.login(Login(email: email, password: password));
      AuthManager.setToken(AuthKeys.ATH_BEARER_TOKEN_API.name, loginResponse.accessToken);
      AuthManager.setToken(AuthKeys.ATH_BEARER_REFRESH_TOKEN_API.name, loginResponse.refreshToken);
      AuthManager.setToken(AuthKeys.ATH_END_OF_BEARER_TOKEN_API.name, DateTime.now().add(const Duration(seconds: 3500)).toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registered and Connected !'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
        ),
      );
      AuthManager.setProfile(Profile(username: username, email: email));
      Navigator.pushNamed(context, '/createProfile');
    } catch (error) { // TODO la plus part du temps c'est que le mdp est pas assez fort !!!
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
      return;
    }
  }


}
