import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
                  labelText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  // Add your forgot password logic here
                },
                child: Text(
                  'Forgot password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Add your log-in logic here
                },
                child: Text('Log In'),
              ),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  // Add your sign-up logic here
                },
                child: Text(
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
}
