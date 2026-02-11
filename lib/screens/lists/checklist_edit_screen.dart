
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/lists/lists_screen.dart';

class ChecklistEditScreen extends StatefulWidget {
  final Checklist? checklist;

  const ChecklistEditScreen({super.key, this.checklist});

  @override
  State<ChecklistEditScreen> createState() => _ChecklistEditScreenState();
}

class _ChecklistEditScreenState extends State<ChecklistEditScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _itemController;
  late final List<ChecklistItem> _items;
  final bool _isEditing;

  _ChecklistEditScreenState() : _isEditing = false; // Default constructor

  @override
  void initState() {
    super.initState();
    final isEditing = widget.checklist != null;
    _titleController = TextEditingController(text: isEditing ? widget.checklist!.title : 'Untitled Checklist');
    _itemController = TextEditingController();
    _items = isEditing
        ? widget.checklist!.items.map((item) => ChecklistItem(title: item.title, isCompleted: item.isCompleted)).toList()
        : [];
  }

  void _addItem() {
    if (_itemController.text.isNotEmpty) {
      setState(() {
        _items.add(ChecklistItem(title: _itemController.text));
        _itemController.clear();
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _saveChecklist() {
    if (_titleController.text.isNotEmpty) {
      final newChecklist = Checklist(
        title: _titleController.text,
        items: _items,
      );
      Navigator.of(context).pop(newChecklist);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: AppColors.textGrey, fontSize: 16)),
        ),
        leadingWidth: 80,
        title: Text(
          widget.checklist != null ? 'Edit Checklist' : 'New Checklist',
          style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveChecklist,
            child: Text(
              widget.checklist != null ? 'Save' : 'Create',
              style: const TextStyle(color: AppColors.primaryBlue, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textDark),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'ADD ITEMS',
              style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.1),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration: const InputDecoration(
                      hintText: 'New item...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.plusCircle, color: AppColors.primaryBlue, size: 28),
                  onPressed: _addItem,
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            Expanded(
              child: _items.isEmpty
                  ? const Center(
                      child: Text(
                      'Items will appear in your checklist as you add them.',
                      style: TextStyle(color: AppColors.textGrey, fontSize: 16),
                      textAlign: TextAlign.center,
                    ))
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return ListTile(
                          leading: Checkbox(
                            value: item.isCompleted,
                            onChanged: (bool? value) {
                              setState(() {
                                item.isCompleted = value ?? false;
                              });
                            },
                             activeColor: AppColors.primaryBlue,
                          ),
                          title: Text(item.title),
                          trailing: IconButton(
                            icon: const Icon(LucideIcons.trash2, color: AppColors.textGrey, size: 20),
                            onPressed: () => _removeItem(index),
                          ),
                          contentPadding: EdgeInsets.zero,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
