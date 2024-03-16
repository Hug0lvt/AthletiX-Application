import 'package:AthletiX/model/authentification/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';
import '../../providers/api/clientApi.dart';

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

  void register(){
    String email = emailController.value.text;
    String username = usernameController.value.text;
    String password = passwordController.value.text;
    String confirmPassword = confirmPasswordController.value.text;

    if(email.isEmpty || password.isEmpty || username.isEmpty || confirmPassword.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('At least one of the fields is empty !'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    if(!password.compareTo(confirmPassword).isEven){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords are different !'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    clientApi.authClientApi.register(Register(email: email, password: password))
        .then((loginResponse) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registered !'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 5),
            ),
          );
          Navigator.pushNamed(context, '/login'); // TODO allé sur la page de créa de profile avant
          return;
        })
        .catchError((error) {
          switch(error.runtimeType){
            case Exception:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.toString()),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                ),
              );
              return;
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('An error occurred !'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                ),
              );
              return;
          }
        });

  }

}
