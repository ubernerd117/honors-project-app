import '../widgets/expandable_text_button.dart';
import '../shared/base_screen.dart';
import 'package:flutter/material.dart';
import '../shared/strings.dart';

class DesignThinking extends StatefulWidget {
  const DesignThinking({super.key});

  @override
  _DesignThinkingState createState() => _DesignThinkingState();
}

class _DesignThinkingState extends State<DesignThinking> {
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
                      'Design Thinking Resources',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Here you can find resources that can help you brainstorm ideas, collect information, and more!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const ExpandableTextButton(
                buttonText: "Ask a Librarian?",
                expandedText: AppStrings.askLibrarian,
                containerColor: Colors.cyan,
              ),
              const SizedBox(width: 10),
              const ExpandableTextButton(
                buttonText: "Institutional Review Board",
                expandedText: AppStrings.institutionalReviewBoard,
                containerColor: Colors.amber,
              ),
              const SizedBox(width: 10),
              const ExpandableTextButton(
                buttonText: "Ask a Faculty Advisor",
                expandedText: AppStrings.askFacultyAdvisor,
                containerColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
