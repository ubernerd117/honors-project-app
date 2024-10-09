import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('My Timeline'),
            onTap: () {
              // Navigate to Profile Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('What is the Honors Project?'),
            onTap: () {
              // Navigate to Project Intro page
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Honors Project Resouces'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/projectResources');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Advisor Guidelines'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/adv_guidelines');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Students FAQ'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/student_faq');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Past Projects'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/pastProjects');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }
}
