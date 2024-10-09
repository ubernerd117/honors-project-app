import '../widgets/expandable_text_button.dart';
import '../shared/base_screen.dart';
import 'package:flutter/material.dart';
import '../shared/strings.dart';

class StudentFaq extends StatefulWidget {
  const StudentFaq({Key? key}) : super(key: key);

  @override
  _StudentFaqState createState() => _StudentFaqState();
}

class _StudentFaqState extends State<StudentFaq> {
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
                      'Students FAQ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Here you can find Honors approved answers to questions asked by students just like you!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const ExpandableTextButton(
                buttonText: "Will I have enough time?",
                expandedText: AppStrings.timeQuestion,
                containerColor: Colors.cyan,
              ),
              const SizedBox(width: 10),
              const ExpandableTextButton(
                buttonText: "Is there research funding?",
                expandedText: AppStrings.fundingQuestion,
                containerColor: Colors.amber,
              ),
              const SizedBox(width: 10),
              const ExpandableTextButton(
                buttonText: "When do most students start?",
                expandedText: AppStrings.startQuestion,
                containerColor: Colors.red,
              ),
              const SizedBox(width: 10),
              const ExpandableTextButton(
                buttonText: "How do I sign up for HNRS 4980?",
                expandedText: AppStrings.signUpQuestion,
                containerColor: Colors.blueGrey,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
