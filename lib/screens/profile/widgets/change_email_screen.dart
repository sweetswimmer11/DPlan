
import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';

class ChangeEmailScreen extends StatelessWidget {
  const ChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text('Email', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('EMAIL ADDRESS', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: 'alex.j@dplan.app',
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 16),
            const Text(
              'You will need to verify your new email address.',
              style: TextStyle(color: AppColors.textGrey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
