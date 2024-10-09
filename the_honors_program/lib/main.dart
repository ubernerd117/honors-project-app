import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_honors_program/firebase_options.dart';
import 'package:the_honors_program/pages/advisor_guidelines.dart';
import 'package:the_honors_program/pages/student_faq.dart';
import 'homepage/homepage.dart';
import 'authentication/login_screen.dart';
import 'authentication/sign_up_screen.dart';
import 'pages/project_overview.dart';
import 'authentication/profile_page.dart';
import 'pages/design_thinking.dart';
import 'pages/scholarship_resources.dart';
import 'pages/project_resources.dart';
import 'pages/past_projects.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const MyHomePage(title: 'The Honors Project'),
        '/project_overview': (context) => const ProjectOverviewPage(),
        '/profile': (context) => const ProfilePage(),
        '/student_faq': (context) => const StudentFaq(),
        '/adv_guidelines': (context) => const AdvisorGuidelines(),
        '/designThinking': (context) => const DesignThinking(),
        '/scholarshipResources': (context) => const ScholarshipResources(),
        '/projectResources': (context) => const ProjectResources(),
        '/pastProjects': (context) => const PastProjects()
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return const MyHomePage(title: 'The Honors Project');
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
