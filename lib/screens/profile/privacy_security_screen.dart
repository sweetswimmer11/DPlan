
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/core/theme/app_colors.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool _analyticsSharing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text('Privacy & Security', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
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
              'ACCESS & PROTECTION',
              style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.1),
            ),
            const SizedBox(height: 16),
            _buildPrivacyOption(
              context,
              icon: LucideIcons.fingerprint,
              title: 'App Lock',
              subtitle: 'FaceID / Passcode',
              trailing: 'On',
              onTap: () {
                // TODO: Navigate to App Lock settings
              },
            ),
             ListTile(
              leading: const Icon(LucideIcons.barChart, color: AppColors.textDark),
              title: const Text('Analytics Sharing', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
              subtitle: const Text('Help improve D-Plan', style: TextStyle(color: AppColors.textGrey)),
              trailing: Switch.adaptive(
                value: _analyticsSharing,
                onChanged: (value) => setState(() => _analyticsSharing = value),
                activeColor: AppColors.primaryBlue,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
            const SizedBox(height: 80),
            _buildEncryptionInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyOption(BuildContext context, {required IconData icon, required String title, required String subtitle, required String trailing, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textDark),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textGrey)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(trailing, style: const TextStyle(color: AppColors.textGrey, fontSize: 16)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textGrey),
        ],
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    );
  }

  Widget _buildEncryptionInfo() {
    return Column(
      children: [
        Icon(LucideIcons.shieldCheck, size: 40, color: AppColors.textGrey.withOpacity(0.5)),
        const SizedBox(height: 24),
        const Text(
          'Your data is encrypted locally on this device and synced securely with your cloud provider.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textGrey, fontSize: 16, height: 1.5),
        ),
      ],
    );
  }
}
