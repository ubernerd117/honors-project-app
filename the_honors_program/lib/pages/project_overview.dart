import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _honors_project_url = Uri.parse(
    'https://www.bgsu.edu/honors-college/current-students/honors-project.html');

class ProjectOverviewPage extends StatelessWidget {
  const ProjectOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Honors Project'),
        backgroundColor: const Color(0xFF4F2C1D), // Brown header color
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Orange Banner Section
            Container(
              color: const Color(0xFFFF6A33), // Orange color
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Honors Project Overview',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Start here to feel confident in the Honors Project from start to finish!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Project Information Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What exactly is the project?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'The Honors Project is a self-designed capstone project that showcases a student’s learning experience with an interdisciplinary subject of one’s choice! From a writing a research paper to designing a board game or a musical, the Honors Project is up to you!',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'All in all, Honors students must have a researched-based project and reflect their findings in a paper. This paper typically includes an overview of the project, a review of relevant literature, a method overview, presentation of results, future implications, and a bibliography.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'HNRS 4980 and HNRS 4990 are required for completion of the Honors Project.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Looking for more information?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Honors College Website Button
                  ],
                ),
              ),
            ),
            // Honors College Website Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFFF6A33), // Orange button color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _launchUrl,
                child: const Text(
                  'BGSU Honors College Website',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF4F2C1D), // Background color brown
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_honors_project_url)) {
    throw Exception('Could not launch $_honors_project_url');
  }
}
