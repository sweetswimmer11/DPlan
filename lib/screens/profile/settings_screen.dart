
import 'package:d_plan/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/profile/account_screen.dart';
import 'package:d_plan/screens/profile/notifications_screen.dart';
import 'package:d_plan/screens/profile/privacy_security_screen.dart';
import 'package:d_plan/screens/profile/support_screen.dart';
import 'package:d_plan/screens/profile/theme_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text('Settings', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(height: 24),
          _buildProfileHeader(),
          const SizedBox(height: 40),
          _buildSettingsList(context),
          const SizedBox(height: 32),
          _buildLogoutButton(context),
          const SizedBox(height: 40),
          _buildAppVersion(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'), // Placeholder
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(LucideIcons.pencil, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Alex Johnson', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 4),
        const Text('alex.j@dplan.app', style: TextStyle(fontSize: 16, color: AppColors.textGrey)),
      ],
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Column(
      children: [
        _buildSettingsItem(context, icon: LucideIcons.user, title: 'Account', onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountScreen()));
        }),
        _buildSettingsItem(context, icon: LucideIcons.sunMoon, title: 'Theme', trailing: 'Light', onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeScreen()));
        }),
        _buildSettingsItem(context, icon: LucideIcons.bell, title: 'Notifications', onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
        }),
        _buildSettingsItem(context, icon: LucideIcons.shield, title: 'Privacy & Security', onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacySecurityScreen()));
        }),
        _buildSettingsItem(context, icon: LucideIcons.helpCircle, title: 'Support', onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => const SupportScreen()));
        }),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
         Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
        );
      },
      icon: const Icon(LucideIcons.logOut, color: AppColors.errorRed),
      label: const Text('Log Out', style: TextStyle(color: AppColors.errorRed, fontSize: 16, fontWeight: FontWeight.w600)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildAppVersion() {
    return const Text(
      'D-PLAN V2.4.0',
      textAlign: TextAlign.center,
      style: TextStyle(color: AppColors.textGrey, fontSize: 12, letterSpacing: 1.2),
    );
  }

  Widget _buildSettingsItem(BuildContext context, {required IconData icon, required String title, String? trailing, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textDark),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null)
            Text(trailing, style: const TextStyle(color: AppColors.textGrey, fontSize: 16)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textGrey),
        ],
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    );
  }
}
