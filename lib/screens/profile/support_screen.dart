
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/core/theme/app_colors.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text('Support', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'HELP & RESOURCES',
              style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.1),
            ),
            const SizedBox(height: 16),
            _buildSupportItem(
              context,
              icon: LucideIcons.helpCircle,
              title: 'Help Center',
              onTap: () {
                // TODO: Navigate to Help Center
              },
            ),
            _buildSupportItem(
              context,
              icon: LucideIcons.mail,
              title: 'Contact Us',
              onTap: () {
                // TODO: Navigate to Contact Us
              },
            ),
            _buildSupportItem(
              context,
              icon: LucideIcons.bug,
              title: 'Report a Bug',
              onTap: () {
                // TODO: Navigate to Report a Bug
              },
            ),
            _buildSupportItem(
              context,
              icon: LucideIcons.fileText,
              title: 'Terms of Service',
              onTap: () {
                // TODO: Navigate to Terms of Service
              },
            ),
            const SizedBox(height: 150),
             const Center(
                 child: Column(
                   children: [
                     Text(
                      'v2.4.0',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textGrey, fontSize: 12, letterSpacing: 1.2),
                                   ),
                      Text(
                      'D-PLAN',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textGrey, fontSize: 12, letterSpacing: 1.2),
                                   ),
                   ],
                 ),
               ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textDark),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textGrey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    );
  }
}
