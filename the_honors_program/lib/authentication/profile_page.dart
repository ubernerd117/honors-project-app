// lib/screens/profile_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import '../shared/base_screen.dart'; // Import the BaseScreen

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user; // Firebase user object

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  // Fetch the current user's profile information
  void fetchUserProfile() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      user = auth.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      bodyContent: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Display user's display name and email from Firebase
            if (user != null) ...[
              Text(
                'Name: ${user!.displayName ?? 'No display name'}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: ${user!.email ?? 'No email'}',
                style: const TextStyle(fontSize: 18),
              ),
            ] else ...[
              // Placeholder while the user data is loading
              const Text('Loading profile...', style: TextStyle(fontSize: 18)),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Log out the user
                FirebaseAuth.instance.signOut().then((_) {
                  Navigator.pushReplacementNamed(context,
                      '/login'); // Redirect to login screen after sign out
                });
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
