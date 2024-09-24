// lib/shared/base_screen.dart
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart'; // Import the AppDrawer

class BaseScreen extends StatelessWidget {
  final Widget bodyContent;

  const BaseScreen({required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('The Honors Project'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open drawer on click
              },
            );
          },
        ),
      ),
      drawer: AppDrawer(),
      body: bodyContent, // Pass the content of the screen here
    );
  }
}
