
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/lists/lists_screen.dart';
import 'package:d_plan/screens/lists/checklist_edit_screen.dart';

class ChecklistDetailScreen extends StatefulWidget {
  final Checklist checklist;

  const ChecklistDetailScreen({super.key, required this.checklist});

  @override
  State<ChecklistDetailScreen> createState() => _ChecklistDetailScreenState();
}

class _ChecklistDetailScreenState extends State<ChecklistDetailScreen> {
  late Checklist _checklist;

  @override
  void initState() {
    super.initState();
    // Create a mutable copy of the checklist
    _checklist = Checklist(
      title: widget.checklist.title,
      items: widget.checklist.items.map((item) => ChecklistItem(title: item.title, isCompleted: item.isCompleted)).toList(),
    );
  }

  void _addItem(String title) {
    if (title.isNotEmpty) {
      setState(() {
        _checklist.items.add(ChecklistItem(title: title));
      });
    }
  }
  
  void _showAddItemDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Item'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Item name'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              _addItem(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _checklist);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
            onPressed: () => Navigator.pop(context, _checklist),
          ),
          title: Text(_checklist.title, style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.edit, color: AppColors.textDark),
              onPressed: () async {
                final updatedChecklist = await Navigator.push<Checklist>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChecklistEditScreen(checklist: _checklist),
                  ),
                );
                if (updatedChecklist != null) {
                  setState(() {
                    _checklist = updatedChecklist;
                  });
                }
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              '${_checklist.items.length} ITEMS',
              style: const TextStyle(color: AppColors.textGrey, letterSpacing: 1.1, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ..._checklist.items.map((item) {
              return CheckboxListTile(
                value: item.isCompleted,
                onChanged: (bool? value) {
                  setState(() {
                    item.isCompleted = value ?? false;
                  });
                },
                title: Text(item.title, style: TextStyle(decoration: item.isCompleted ? TextDecoration.lineThrough : TextDecoration.none)),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.primaryBlue,
                contentPadding: EdgeInsets.zero,
              );
            }).toList(),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: _showAddItemDialog,
              icon: const Icon(Icons.add, color: AppColors.primaryBlue),
              label: const Text('Add item', style: TextStyle(color: AppColors.primaryBlue)),
              style: TextButton.styleFrom(
                 padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                 alignment: Alignment.centerLeft,
              ),
            )
          ],
        ),
      ),
    );
  }
}
