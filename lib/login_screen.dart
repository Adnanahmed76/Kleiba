import 'package:aeshthatic/screens/movies_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_services.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await Provider.of<AuthService>(context, listen: false).signInWithGoogle();
              // Navigate to MovieListScreen after successful login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MovieListScreen()),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to sign in with Google: $e')),
              );
            }
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
