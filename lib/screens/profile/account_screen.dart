
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/profile/widgets/change_name_screen.dart';
import 'package:d_plan/screens/profile/widgets/change_email_screen.dart';
import 'package:d_plan/screens/profile/widgets/change_password_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text('Account', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 48),
            _buildAccountActions(context),
            const SizedBox(height: 32),
            _buildDeleteAccount(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'), // Placeholder
        ),
        const SizedBox(height: 16),
        const Text('Alex Johnson', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 4),
        const Text('alex.j@dplan.app', style: TextStyle(fontSize: 16, color: AppColors.textGrey)),
      ],
    );
  }

  Widget _buildAccountActions(BuildContext context) {
    return Column(
      children: [
        _buildListTile(
          context,
          title: 'NAME',
          subtitle: 'Alex Johnson',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangeNameScreen())),
        ),
        const Divider(color: AppColors.borderGrey, height: 1),
        _buildListTile(
          context,
          title: 'EMAIL',
          subtitle: 'alex.j@dplan.app',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangeEmailScreen())),
        ),
        const SizedBox(height: 24),
         _buildListTile(
          context,
          title: 'Change Password',
          isSimple: true,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen())),
        ),

      ],
    );
  }

  Widget _buildDeleteAccount(BuildContext context) {
    return Column(
      children: [
        OutlinedButton.icon(
           onPressed: () {
            // TODO: Implement delete account logic
          },
          icon: const Icon(LucideIcons.trash2, color: AppColors.errorRed),
          label: const Text('Delete Account', style: TextStyle(color: AppColors.errorRed, fontWeight: FontWeight.bold)),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.errorRed, width: 1.5),
             minimumSize: const Size(double.infinity, 56),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Deleting your account will permanently remove all your data. This action cannot be undone.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: AppColors.textGrey),
        ),
      ],
    );
  }

  Widget _buildListTile(BuildContext context, {required String title, String? subtitle, bool isSimple = false, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title, style: TextStyle(color: isSimple ? AppColors.textDark: AppColors.textGrey, fontSize: isSimple ? 16: 12, fontWeight: isSimple ? FontWeight.w600 : FontWeight.normal )),
      subtitle: isSimple ? null : Text(subtitle!, style: const TextStyle(color: AppColors.textDark, fontSize: 16, fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textGrey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
    );
  }
}
