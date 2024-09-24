// lib/homepage/homepage.dart
import 'package:flutter/material.dart';
import '../shared/base_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      bodyContent: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.deepOrange,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Freddie!',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: 0.63,
                        strokeWidth: 8,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    Text(
                      '63%',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Project Foundations',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    shrinkWrap: true,
                    children: [
                      _buildGridItem(Colors.teal, Icons.book,
                          'What is the Honors Project?'),
                      _buildGridItem(
                          Colors.pink, Icons.work, 'Honors Project Resources'),
                      _buildGridItem(Colors.brown[300]!, Icons.check_box,
                          'Advisor Guidelines'),
                      _buildGridItem(Colors.amber, Icons.chat, 'Student Q&A'),
                      _buildGridItem(
                          Colors.deepOrange, Icons.history, 'Past Projects'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(Color color, IconData icon, String text) {
    return GestureDetector(
      onTap: () {
        if (text == 'What is the Honors Project?') {
          Navigator.pushNamed(context, '/project_overview');
        }
        // Handle other button taps here
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
