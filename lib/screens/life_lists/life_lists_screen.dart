
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/life_lists/life_list_item_edit_screen.dart';

enum ItemType { book, movie, series, plan }

enum ItemStatus { toDo, doing, done }

class LifeListItem {
  String title;
  String? subtitle; // For plans
  ItemType type;
  ItemStatus status;

  LifeListItem({
    required this.title,
    this.subtitle,
    required this.type,
    this.status = ItemStatus.toDo,
  });
}

class LifeListsScreen extends StatefulWidget {
  const LifeListsScreen({super.key});

  @override
  State<LifeListsScreen> createState() => _LifeListsScreenState();
}

class _LifeListsScreenState extends State<LifeListsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<LifeListItem> _items = [
    // Books
    LifeListItem(title: 'The Great Gatsby', type: ItemType.book, status: ItemStatus.done),
    LifeListItem(title: 'To Kill a Mockingbird', type: ItemType.book, status: ItemStatus.doing),
    LifeListItem(title: '1984', type: ItemType.book, status: ItemStatus.toDo),
    LifeListItem(title: 'Brave New World', type: ItemType.book, status: ItemStatus.toDo),
    // Movies
    LifeListItem(title: 'Inception', type: ItemType.movie, status: ItemStatus.done),
    LifeListItem(title: 'Interstellar', type: ItemType.movie, status: ItemStatus.doing),
    LifeListItem(title: 'The Dark Knight', type: ItemType.movie, status: ItemStatus.done),
    LifeListItem(title: 'Dune: Part Two', type: ItemType.movie, status: ItemStatus.toDo),
    LifeListItem(title: 'Oppenheimer', type: ItemType.movie, status: ItemStatus.toDo),
    // Series
    LifeListItem(title: 'Breaking Bad', type: ItemType.series, status: ItemStatus.done),
    LifeListItem(title: 'Succession', type: ItemType.series, status: ItemStatus.doing),
    LifeListItem(title: 'The Bear', type: ItemType.series, status: ItemStatus.doing),
    LifeListItem(title: 'Severance', type: ItemType.series, status: ItemStatus.toDo),
    LifeListItem(title: 'The White Lotus', type: ItemType.series, status: ItemStatus.toDo),
    // Plans
    LifeListItem(title: 'Visit Japan', subtitle: 'Countries to visit', type: ItemType.plan, status: ItemStatus.toDo),
    LifeListItem(title: 'Paris Trip', subtitle: 'Visited places', type: ItemType.plan, status: ItemStatus.done),
    LifeListItem(title: 'Beach Vacation', subtitle: 'Vacations', type: ItemType.plan, status: ItemStatus.toDo),
    LifeListItem(title: 'Learn Spanish', subtitle: 'Year goals', type: ItemType.plan, status: ItemStatus.doing),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addItem() async {
    final newItem = await showModalBottomSheet<LifeListItem>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LifeListItemEditScreen(),
    );
    if (newItem != null) {
      setState(() {
        _items.add(newItem);
      });
    }
  }

  void _editItem(LifeListItem item) async {
    final updatedItem = await showModalBottomSheet<LifeListItem>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LifeListItemEditScreen(item: item),
    );
    if (updatedItem != null) {
      setState(() {
        final index = _items.indexOf(item);
        if (index != -1) {
          _items[index] = updatedItem;
        }
      });
    }
  }

  void _deleteItem(LifeListItem item) {
    setState(() {
      _items.remove(item);
    });
  }

  void _changeStatus(LifeListItem item) {
     showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Change Status'),
          children: ItemStatus.values.map((status) {
            return SimpleDialogOption(
              onPressed: () {
                setState(() {
                  item.status = status;
                });
                Navigator.pop(context);
              },
              child: Text(status.name.toUpperCase()),
            );
          }).toList(),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Life Lists', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.plus, size: 28, color: AppColors.textDark),
            onPressed: _addItem,
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
            Tab(text: 'Books'),
            Tab(text: 'Movies'),
            Tab(text: 'Series'),
            Tab(text: 'Plans'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(ItemType.book),
          _buildList(ItemType.movie),
          _buildList(ItemType.series),
          _buildList(ItemType.plan),
        ],
      ),
    );
  }

  Widget _buildList(ItemType type) {
    final filteredItems = _items.where((item) => item.type == type).toList();
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return _buildItemCard(item);
      },
    );
  }

  Widget _buildItemCard(LifeListItem item) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.borderGrey.withOpacity(0.5), width: 1),
      ),
      color: AppColors.surfaceWhite,
      child: ListTile(
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
        subtitle: item.subtitle != null ? Text(item.subtitle!, style: const TextStyle(color: AppColors.textGrey)) : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatusChip(item.status),
            _buildPopupMenu(item),
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );
  }

  Widget _buildStatusChip(ItemStatus status) {
    Color color;
    String text;
    switch (status) {
      case ItemStatus.toDo:
        color = AppColors.textGrey;
        text = 'To Do';
        break;
      case ItemStatus.doing:
        color = AppColors.primaryBlue;
        text = 'Doing';
        break;
      case ItemStatus.done:
        color = AppColors.successGreen;
        text = 'Done';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

   Widget _buildPopupMenu(LifeListItem item) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'edit') {
          _editItem(item);
        } else if (value == 'change_status') {
           _changeStatus(item);
        } else if (value == 'delete') {
          _deleteItem(item);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'edit',
          child: Text('Edit'),
        ),
         const PopupMenuItem<String>(
          value: 'change_status',
          child: Text('Change Status'),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Text('Delete', style: TextStyle(color: AppColors.errorRed)),
        ),
      ],
      icon: const Icon(LucideIcons.moreHorizontal, color: AppColors.textGrey),
    );
  }
}

