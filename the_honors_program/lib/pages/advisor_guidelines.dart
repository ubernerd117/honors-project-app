import '../widgets/expandable_text_button.dart';
import '../shared/base_screen.dart';
import 'package:flutter/material.dart';
import '../shared/strings.dart';

class AdvisorGuidelines extends StatefulWidget {
  const AdvisorGuidelines({Key? key}) : super(key: key);

  @override
  _AdvisorGuidleinesState createState() => _AdvisorGuidleinesState();
}

class _AdvisorGuidleinesState extends State<AdvisorGuidelines> {
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
                      'Advisor Guidelines',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tips and Trick for how to approach finding the perfect advisor tailored to your project.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [Text(AppStrings.advOverview)],
                  )),
              const SizedBox(width: 10),
              const ExpandableTextButton(
                buttonText: "Who can be an Advisor?",
                expandedText: AppStrings.facultyAdvisorQualifications,
                containerColor: Colors.blueGrey,
              ),
              const ExpandableTextButton(
                buttonText:
                    "What are the Responsibilities of the Faculty Advisor?",
                expandedText: AppStrings.facultyAdvisorResponsibilities,
                containerColor: Colors.amber,
              ),
              const SizedBox(width: 10),
              const ExpandableTextButton(
                buttonText: "What should the project length be?",
                expandedText: AppStrings.honorsProjectLengthGuidelines,
                containerColor: Colors.red,
              ),
              const SizedBox(width: 10),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
