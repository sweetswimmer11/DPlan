
import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text('Change Password', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement save logic
              Navigator.of(context).pop();
            },
            child: const Text('Save', style: TextStyle(color: AppColors.primaryBlue, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPasswordField('CURRENT PASSWORD', 'Enter current password'),
            const SizedBox(height: 24),
            _buildPasswordField('NEW PASSWORD', 'Enter new password'),
            const SizedBox(height: 24),
            _buildPasswordField('CONFIRM NEW PASSWORD', 'Confirm new password'),
             const SizedBox(height: 24),
            const Text(
              'Make sure your new password is at least 8 characters long and includes a mix of numbers and special characters.',
              style: TextStyle(color: AppColors.textGrey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}
