
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/notes/note_edit_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, String>> _notes = [
    {
      'title': 'Meeting Minutes',
      'content': 'Review the quarterly goals and project milestones with the team. Key objectives for Q3: Finalize the mobile interface redesign, Improve server server response times, Expand the beta testing group. We discussed the importance of maintaining an ultra-minimalist aesthetic throughout the application to ensure user focus remains on the content itself.',
    },
    {
      'title': 'Project Ideas',
      'content': 'Exploring new features for the mobile app...',
    },
    {
      'title': 'Grocery List',
      'content': 'Milk, organic eggs, sourdough bread,...',
    },
    {
      'title': 'Workout Plan',
      'content': 'Morning routine: 20 minutes cardio, 30...',
    },
    {
      'title': 'Travel Itinerary',
      'content': 'Flight leaves at 10 AM. Book the airport...',
    },
     {
      'title': 'Reading List',
      'content': 'The Design of Everyday Things, Atomic...',
    },
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
          'Notes',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.textDark),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.search, size: 24, color: AppColors.textDark),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.plus, size: 28, color: AppColors.textDark),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => const NoteEditScreen()));
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return _buildNoteCard(context, note['title']!, note['content']!);
        },
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, String title, String content) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.borderGrey.withOpacity(0.5), width: 1),
      ),
      color: AppColors.surfaceWhite,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteEditScreen(initialTitle: title, initialContent: content)));
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textDark),
              ),
              const SizedBox(height: 8),
              Text(
                content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16, color: AppColors.textGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
