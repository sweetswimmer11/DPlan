
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/core/theme/app_colors.dart';

enum TaskStatus { toDo, inProgress, done }

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  final List<Map<String, dynamic>> _tasks = [
    {'id': 1, 'title': 'Prepare Q4 Report', 'status': TaskStatus.toDo},
    {'id': 2, 'title': 'Email Marketing Campaign', 'status': TaskStatus.toDo},
    {'id': 3, 'title': 'Update Website Assets', 'status': TaskStatus.toDo},
    {'id': 4, 'title': 'Mobile App Development', 'status': TaskStatus.inProgress},
    {'id': 5, 'title': 'User Research Interviews', 'status': TaskStatus.inProgress},
    {'id': 6, 'title': 'Setup project', 'status': TaskStatus.done},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showTaskDialog({Map<String, dynamic>? task}) {
    final isEditing = task != null;
    final _titleController = TextEditingController(text: isEditing ? task['title'] : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Task' : 'New Task'),
          content: TextField(
            controller: _titleController,
            decoration: const InputDecoration(hintText: 'Task Title'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  setState(() {
                    if (isEditing) {
                      task['title'] = _titleController.text;
                    } else {
                      _tasks.add({
                        'id': _tasks.length + 1,
                        'title': _titleController.text,
                        'status': TaskStatus.toDo,
                      });
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showFilterDialog() {
    final _searchController = TextEditingController(text: _searchQuery);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter Tasks'),
          content: TextField(
            controller: _searchController,
            decoration: const InputDecoration(hintText: 'Search...'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _searchQuery = _searchController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  void _moveTask(Map<String, dynamic> task, TaskStatus newStatus) {
    setState(() {
      task['status'] = newStatus;
    });
  }

  void _deleteTask(Map<String, dynamic> task) {
    setState(() {
      _tasks.remove(task);
    });
  }
  
  List<Map<String, dynamic>> _getFilteredTasks(TaskStatus status) {
    return _tasks
        .where((t) => t['status'] == status && t['title'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final toDoTasks = _getFilteredTasks(TaskStatus.toDo);
    final inProgressTasks = _getFilteredTasks(TaskStatus.inProgress);
    final doneTasks = _getFilteredTasks(TaskStatus.done);

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
          'Task Board',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.textDark),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.filter, size: 24, color: AppColors.textDark),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(LucideIcons.plus, size: 28, color: AppColors.textDark),
            onPressed: () => _showTaskDialog(),
          ),
          const SizedBox(width: 16),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryBlue,
          unselectedLabelColor: AppColors.textGrey,
          indicatorColor: AppColors.primaryBlue,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'To Do'),
            Tab(text: 'In Progress'),
            Tab(text: 'Done'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTaskList(toDoTasks, 'To Do'),
          _buildTaskList(inProgressTasks, 'In Progress'),
          _buildTaskList(doneTasks, 'Done'),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<Map<String, dynamic>> tasks, String title) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.borderGrey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                tasks.length.toString(),
                style: const TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...tasks.map((task) => _buildTaskCard(task)).toList(),
      ],
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.borderGrey.withOpacity(0.5), width: 1),
      ),
      color: AppColors.surfaceWhite,
      child: ListTile(
        title: Text(task['title'], style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
               _showTaskDialog(task: task);
            } else if (value == 'todo') {
              _moveTask(task, TaskStatus.toDo);
            } else if (value == 'inprogress') {
              _moveTask(task, TaskStatus.inProgress);
            } else if (value == 'done') {
              _moveTask(task, TaskStatus.done);
            } else if (value == 'delete') {
              _deleteTask(task);
            }
          },
          itemBuilder: (BuildContext context) {
            final currentStatus = task['status'] as TaskStatus;
            List<PopupMenuEntry<String>> items = [
              const PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
            ];

            switch (currentStatus) {
              case TaskStatus.toDo:
                items.add(const PopupMenuItem<String>(value: 'inprogress', child: Text('Move to In Progress')));
                items.add(const PopupMenuItem<String>(value: 'done', child: Text('Move to Done')));
                break;
              case TaskStatus.inProgress:
                items.add(const PopupMenuItem<String>(value: 'done', child: Text('Move to Done')));
                items.add(const PopupMenuItem<String>(value: 'todo', child: Text('Move to To Do')));
                break;
              case TaskStatus.done:
                items.add(const PopupMenuItem<String>(value: 'todo', child: Text('Move to To Do')));
                items.add(const PopupMenuItem<String>(value: 'inprogress', child: Text('Move to In Progress')));
                break;
            }

            items.add(const PopupMenuDivider());
            items.add(PopupMenuItem<String>(
              value: 'delete',
              child: Text('Delete', style: TextStyle(color: AppColors.errorRed)),
            ));

            return items;
          },
          icon: const Icon(LucideIcons.moreHorizontal, color: AppColors.textGrey),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );
  }
}
