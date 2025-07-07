import 'package:flutter/material.dart';
import 'RegistrationPage.dart';
import '../services/googlelogin.dart';
import '../services/applesignin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  Future<void> _signInWithGoogle() async {
    try {
      final userCredential = await GoogleLoginService.signInWithGoogle();
      if (userCredential != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google sign-in successful!')),
        );
        // Optionally navigate to a new page here
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: \$e')),
      );
    }
  }

  Future<void> _signInWithApple() async {
    try {
      final userCredential = await AppleSignInService.signInWithApple();
      if (userCredential != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Apple sign-in successful!')),
        );
        // Optionally navigate to a new page here
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Apple sign-in failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        height:MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width, 
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
                Colors.deepPurple.shade300,
                Colors.deepPurple.shade600,
                Colors.deepPurple.shade900
            
            ],
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
                Image.asset(
                  'assets/logos/logo_black.png',
                  height: 120,
                  width: 120,
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Login'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegistrationPage()),
                    );
                  },
                  child: const Text('Don\'t have an account? Register'),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.g_mobiledata, size: 40, color: Colors.red),
                      onPressed: _signInWithGoogle,
                    ),
                    const SizedBox(width: 24),
                    IconButton(
                      icon: const Icon(Icons.apple, size: 40, color: Colors.black),
                      onPressed: _signInWithApple,
                    ),
                  ],
                ),
            ]
        )
      ) 
  );
  }
}