
import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/screens/tasks/tasks_screen.dart';
import 'package:d_plan/screens/notes/notes_screen.dart';
import 'package:d_plan/screens/lists/lists_screen.dart';
import 'package:d_plan/screens/focus/focus_screen.dart';
import 'package:d_plan/screens/life_lists/life_lists_screen.dart';
import 'package:d_plan/screens/profile/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        title: const Text(
          'D-Plan',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.textDark),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.userCircle2, size: 28, color: AppColors.textDark),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: [
            _buildNavigationCard(
              context,
              title: 'Task Board',
              icon: LucideIcons.layoutDashboard,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TasksScreen())),
            ),
            _buildNavigationCard(
              context,
              title: 'Notes',
              icon: LucideIcons.book,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotesScreen())),
            ),
            _buildNavigationCard(
              context,
              title: 'Checklist',
              icon: LucideIcons.checkSquare,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ListsScreen())),
            ),
            _buildNavigationCard(
              context,
              title: 'Focus',
              icon: LucideIcons.timer,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FocusScreen())),
            ),
            _buildNavigationCard(
              context,
              title: 'Life Lists',
              icon: LucideIcons.layers,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LifeListsScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.borderGrey.withOpacity(0.5), width: 1),
      ),
      color: AppColors.surfaceWhite,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textDark),
              ),
              Icon(icon, color: AppColors.textGrey, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
