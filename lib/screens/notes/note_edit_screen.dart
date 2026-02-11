
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/core/theme/app_colors.dart';

class NoteEditScreen extends StatefulWidget {
  final String? initialTitle;
  final String? initialContent;

  const NoteEditScreen({super.key, this.initialTitle, this.initialContent});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _contentController = TextEditingController(text: widget.initialContent);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialTitle != null;

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
        title: isEditing
            ? Text(
                widget.initialTitle!,
                style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              )
            : null,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement save logic
              Navigator.of(context).pop();
            },
            child: Text(isEditing ? 'Done' : 'Save', style: const TextStyle(color: AppColors.primaryBlue, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              autofocus: !isEditing,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textDark),
              decoration: const InputDecoration(
                hintText: 'Note Title',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                style: const TextStyle(fontSize: 18, color: AppColors.textDark, height: 1.5),
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Start typing...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildFormattingToolbar(),
    );
  }

  Widget _buildFormattingToolbar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(LucideIcons.bold, color: AppColors.textDark)),
                IconButton(onPressed: () {}, icon: const Icon(LucideIcons.list, color: AppColors.textDark)),
                IconButton(onPressed: () {}, icon: const Icon(LucideIcons.listChecks, color: AppColors.textDark)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
