import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AthletiX',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                obscureText: true, // Masque le texte pour le champ de mot de passe
                decoration: InputDecoration(
                  labelText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                obscureText: true, // Masque le texte pour le champ de confirmation de mot de passe
                decoration: InputDecoration(
                  labelText: 'Confirm password',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Add your sign-up logic here
                },
                child: Text('Sign Up'),
              ),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  // Add your log-in logic here
                },
                child: Text(
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
}
