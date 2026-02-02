import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/splash_screen.dart';
import 'package:d_plan/screens/onboarding/onboarding_screen.dart';
import 'package:d_plan/screens/auth/login_screen.dart';
import 'package:d_plan/screens/auth/register_screen.dart';
import 'package:d_plan/screens/main_wrapper.dart';
import 'package:d_plan/screens/lists/checklist_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D-Plan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        fontFamily: 'Manrope', // Assuming font is available or fallback to default
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryPurple,
          background: AppColors.backgroundLight,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundLight,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const MainWrapper(),
        '/checklist-detail': (context) => const ChecklistDetailScreen(),
      },
    );
  }
}
