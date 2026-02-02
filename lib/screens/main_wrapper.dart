import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/home/home_screen.dart';
import 'package:d_plan/screens/tasks/tasks_screen.dart';
import 'package:d_plan/screens/focus/focus_screen.dart';
import 'package:d_plan/screens/notes/notes_screen.dart';
import 'package:d_plan/screens/lists/lists_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    TasksScreen(),
    FocusScreen(),
    NotesScreen(),
    ListsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: Border(top: BorderSide(color: Colors.grey[200]!)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home, 'Home'),
                _buildNavItem(1, Icons.check_circle_outline, 'Tasks'),
                _buildNavItem(2, Icons.timer_outlined, 'Focus'),
                _buildNavItem(3, Icons.description_outlined, 'Notes'),
                _buildNavItem(4, Icons.format_list_bulleted, 'Lists'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = _currentIndex == index;
    // Specific colors based on design tabs
    Color color = isSelected ? AppColors.primaryBlue : AppColors.textGrey;
    if (index == 2 && isSelected) color = AppColors.primaryPurple; // Focus might differ

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
