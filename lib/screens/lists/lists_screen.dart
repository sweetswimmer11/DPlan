
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/lists/checklist_detail_screen.dart';
import 'package:d_plan/screens/lists/checklist_edit_screen.dart';

class ChecklistItem {
  String title;
  bool isCompleted;

  ChecklistItem({required this.title, this.isCompleted = false});
}

class Checklist {
  String title;
  List<ChecklistItem> items;

  Checklist({required this.title, required this.items});

  double get progress {
    if (items.isEmpty) return 0.0;
    final completedCount = items.where((item) => item.isCompleted).length;
    return completedCount / items.length;
  }
}

class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key});

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  final List<Checklist> _checklists = [
    Checklist(title: 'Morning Routine', items: [
      ChecklistItem(title: 'Drink water', isCompleted: true),
      ChecklistItem(title: 'Meditate', isCompleted: true),
      ChecklistItem(title: 'Exercise'),
      ChecklistItem(title: 'Read'),
    ]),
    Checklist(title: 'Work Setup', items: [
      ChecklistItem(title: 'Open IDE', isCompleted: true),
      ChecklistItem(title: 'Check emails', isCompleted: true),
      ChecklistItem(title: 'Review calendar', isCompleted: true),
    ]),
    Checklist(title: 'Travel Essentials', items: [
      ChecklistItem(title: 'Passport'),
      ChecklistItem(title: 'Tickets'),
      ChecklistItem(title: 'Hotel confirmation'),
    ]),
    Checklist(title: 'Grocery List', items: [
      ChecklistItem(title: 'Milk', isCompleted: true),
      ChecklistItem(title: 'Eggs', isCompleted: true),
      ChecklistItem(title: 'Bread', isCompleted: true),
      ChecklistItem(title: 'Cheese'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
         leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Checklist',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.textDark),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.search, size: 24, color: AppColors.textDark),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LucideIcons.plus, size: 28, color: AppColors.textDark),
            onPressed: _navigateAndCreateChecklist,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: _checklists.length,
        itemBuilder: (context, index) {
          final checklist = _checklists[index];
          return _buildChecklistCard(checklist);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndCreateChecklist,
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _navigateAndCreateChecklist() async {
    final newChecklist = await Navigator.push<Checklist>(
      context,
      MaterialPageRoute(builder: (context) => const ChecklistEditScreen()),
    );
    if (newChecklist != null) {
      setState(() {
        _checklists.add(newChecklist);
      });
    }
  }

  Widget _buildChecklistCard(Checklist checklist) {
    final progress = checklist.progress;
    final percentage = (progress * 100).toInt();
    String statusText;
    Color progressColor;

    if (progress == 1.0) {
      statusText = '100% COMPLETED';
      progressColor = AppColors.successGreen;
    } else if (progress > 0) {
      statusText = '$percentage% COMPLETED';
      progressColor = AppColors.primaryBlue;
    } else {
      statusText = 'NOT STARTED';
      progressColor = AppColors.borderGrey;
    }

    return Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.borderGrey.withOpacity(0.5), width: 1),
        ),
        color: AppColors.surfaceWhite,
        child: InkWell(
            onTap: () async {
              final updatedChecklist = await Navigator.push<Checklist>(
                context,
                MaterialPageRoute(
                  builder: (context) => ChecklistDetailScreen(checklist: checklist),
                ),
              );
              if (updatedChecklist != null) {
                setState(() {
                  final index = _checklists.indexWhere((c) => c.title == updatedChecklist.title);
                   if (index != -1) {
                     _checklists[index] = updatedChecklist;
                   }
                });
              }
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        checklist.title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textDark),
                      ),
                      if (progress == 1.0)
                        const Icon(Icons.check_circle, color: AppColors.successGreen)
                      else
                        Text('$percentage%', style: const TextStyle(fontSize: 16, color: AppColors.textGrey, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.borderGrey.withOpacity(0.2),
                    color: progressColor,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    statusText,
                    style: const TextStyle(fontSize: 12, color: AppColors.textGrey, letterSpacing: 0.5),
                  ),
                ],
              ),
            )));
  }
}
