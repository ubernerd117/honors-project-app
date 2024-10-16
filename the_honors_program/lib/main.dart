import 'package:flutter/material.dart';
import 'package:the_honors_program/static_pages/advisor_guidelines.dart';
import 'package:the_honors_program/static_pages/student_faq.dart';
import 'homepage/homepage.dart';
import 'static_pages/project_overview.dart';
import 'static_pages/design_thinking.dart';
import 'static_pages/scholarship_resources.dart';
import 'static_pages/project_resources.dart';
import 'static_pages/past_projects.dart';
import 'tracking/todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 79, 44, 29),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      home: const MyHomePage(title: 'The Honors Project'),
      routes: {
        '/home': (context) => const MyHomePage(title: 'The Honors Project'),
        '/project_overview': (context) => const ProjectOverviewPage(),
        '/student_faq': (context) => const StudentFaq(),
        '/adv_guidelines': (context) => const AdvisorGuidelines(),
        '/designThinking': (context) => const DesignThinking(),
        '/scholarshipResources': (context) => const ScholarshipResources(),
        '/projectResources': (context) => const ProjectResources(),
        '/pastProjects': (context) => const PastProjects(),
        '/todo_page': (context) =>
            const TodoPage(title: 'Todo List'), // Updated this line
      },
    );
  }
}
