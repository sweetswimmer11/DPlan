
import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  String _selectedTheme = 'Light Mode';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text('Theme', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            _buildThemeOption('Light Mode'),
            _buildThemeOption('Dark Mode'),
            _buildThemeOption('System Default'),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(String title) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600)),
      trailing: _selectedTheme == title
          ? const Icon(Icons.check, color: AppColors.primaryBlue)
          : null,
      onTap: () {
        setState(() {
          _selectedTheme = title;
          // TODO: Add logic to actually change the theme
        });
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    );
  }
}
