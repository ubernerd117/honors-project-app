import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Placeholder for Logo and Title
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Replace this with your logo
                    Icon(Icons.school, size: 80, color: Colors.deepOrange),
                    SizedBox(height: 16),
                    Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.05), // Add vertical space

              // Form Container
              Container(
                width: size.width * 0.85,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    // Email TextField
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password TextField
                    TextField(
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          // Navigate to home page after signup
                          Navigator.pushReplacementNamed(context, '/home');
                        } catch (e) {
                          print(e);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary, // Match theme color
                        minimumSize:
                            const Size.fromHeight(50), // Make button full-width
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Login Button
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Already have an account? Log in',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
