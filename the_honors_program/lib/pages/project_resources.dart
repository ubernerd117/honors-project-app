import '../widgets/expandable_text_button.dart';
import '../shared/base_screen.dart';
import 'package:flutter/material.dart';
import '../shared/strings.dart';

class ProjectResources extends StatefulWidget {
  const ProjectResources({Key? key}) : super(key: key);

  @override
  _ProjectResourcesState createState() => _ProjectResourcesState();
}

class _ProjectResourcesState extends State<ProjectResources> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      bodyContent: SingleChildScrollView(
        // Added SingleChildScrollView here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: const Color(0xFFFF6A33), // Orange color
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Honors Project Resources',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'The one-stop shop for project-related help from IRB requirements to Design Thinking resources.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // First Button: Design Thinking Resources
              SizedBox(
                width: double.infinity, // Make the button take full width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Colors.amber, // Background color
                    textStyle: const TextStyle(fontSize: 20), // Text size
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/designThinking');
                  },
                  child: const Text('Design Thinking Resources'),
                ),
              ),
              const SizedBox(height: 20), // Space between buttons
              // Second Button: Scholarship Resources
              SizedBox(
                width: double.infinity, // Make the button take full width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Colors.cyanAccent, // Background color
                    textStyle: const TextStyle(fontSize: 20), // Text size
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/scholarshipResources');
                  },
                  child: const Text('Scholarship Resources'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
