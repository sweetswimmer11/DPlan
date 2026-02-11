
import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/main_wrapper.dart';
import 'package:d_plan/screens/auth/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 48),
                _buildLoginForm(context),
                const SizedBox(height: 32),
                _buildSocialLogin(),
                const SizedBox(height: 48),
                _buildSignupPrompt(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        Text(
          'D-Plan',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textDark),
        ),
        SizedBox(height: 12),
        Text(
          'Welcome Back',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textDark, letterSpacing: -0.5),
        ),
        SizedBox(height: 8),
        Text(
          'Sign in to continue your productivity journey.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: AppColors.textGrey),
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFormField(
          decoration: _buildInputDecoration('Email Address', Icons.email_outlined),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: _buildInputDecoration('Password', Icons.lock_outline),
          obscureText: true,
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {},
          child: const Text('Forgot Password?', style: TextStyle(color: AppColors.textGrey)),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
               Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainWrapper()),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: Divider(color: AppColors.borderGrey)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Or continue with', style: TextStyle(color: AppColors.textGrey)),
            ),
            Expanded(child: Divider(color: AppColors.borderGrey)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _buildSocialButton(icon: Icons.apple, label: 'Apple')),
            const SizedBox(width: 16),
            Expanded(child: _buildSocialButton(label: 'Google')), // Placeholder for Google icon
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({IconData? icon, required String label}) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: icon != null ? Icon(icon, color: AppColors.textDark) : const SizedBox.shrink(), // Add logic for Google icon asset
      label: Text(label, style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        side: const BorderSide(color: AppColors.borderGrey, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildSignupPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?", style: TextStyle(color: AppColors.textGrey)),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: const Text('Sign up', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(String hintText, IconData icon) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: AppColors.textGrey),
      prefixIcon: Icon(icon, color: AppColors.textGrey),
      filled: true,
      fillColor: AppColors.backgroundLight,
      contentPadding: const EdgeInsets.all(20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
