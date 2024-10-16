import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.timeline),
                  title: const Text('My Timeline'),
                  onTap: () {
                    // Navigate to Profile Page
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text('What is the Honors Project?'),
                  onTap: () {
                    // Navigate to Project Intro page
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.library_books),
                  title: const Text('Honors Project Resources'),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, '/projectResources');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.supervisor_account),
                  title: const Text('Advisor Guidelines'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/adv_guidelines');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.question_answer),
                  title: const Text('Students FAQ'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/student_faq');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.history_edu),
                  title: const Text('Past Projects'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/pastProjects');
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_circle),
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
