
import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Onboarding page data
  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'All-in-one planning',
      'description': 'Manage tasks, notes, and focus sessions in one place.',
    },
    {
      'title': 'Focus & Productivity',
      'description': 'Master your time with integrated Pomodoro timers and distraction-free modes.',
    },
    {
      'title': 'Life Goals & Lists',
      'description': 'Track your long-term aspirations and daily checklists in a single, beautiful space.',
    }
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceWhite,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceWhite,
        elevation: 0,
        title: const Text('D-Plan', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: _navigateToLogin,
            child: const Text('Skip', style: TextStyle(color: AppColors.textGrey)),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final item = _onboardingData[index];
                  return _buildOnboardingPage(
                    title: item['title']!,
                    description: item['description']!,
                    icon: _getIconForPage(index),
                  );
                },
              ),
            ),
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({required String title, required String description, Widget? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            icon,
            const SizedBox(height: 40),
          ] else ...[
            Container(
              width: 48,
              height: 4,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(height: 36),
          ],
          Text(
            title,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: AppColors.textDark,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.textGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIconForPage(int index) {
    if (index == 1) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.timer_outlined, color: AppColors.primaryBlue, size: 40),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildBottomControls() {
    bool isLastPage = _currentPage == _onboardingData.length - 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(_onboardingData.length, (index) {
              return Container(
                width: _currentPage == index ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _currentPage == index ? AppColors.primaryBlue : AppColors.borderGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                if (isLastPage) {
                  _navigateToLogin();
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLastPage ? 'Get Started' : 'Next',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  if (!isLastPage) const SizedBox(width: 8),
                  if (!isLastPage) const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
