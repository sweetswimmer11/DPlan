
import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/life_lists/life_lists_screen.dart';

class LifeListItemEditScreen extends StatefulWidget {
  final LifeListItem? item;

  const LifeListItemEditScreen({super.key, this.item});

  @override
  State<LifeListItemEditScreen> createState() => _LifeListItemEditScreenState();
}

class _LifeListItemEditScreenState extends State<LifeListItemEditScreen> {
  late final TextEditingController _titleController;
  late ItemType _selectedType;
  late ItemStatus _selectedStatus;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item?.title ?? '');
    _selectedType = widget.item?.type ?? ItemType.book;
    _selectedStatus = widget.item?.status ?? ItemStatus.toDo;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveItem() {
    if (_titleController.text.isEmpty) return;

    final newItem = LifeListItem(
      title: _titleController.text,
      type: _selectedType,
      status: _selectedStatus,
      // Preserve subtitle if it's a plan and is being edited
      subtitle: widget.item?.type == ItemType.plan ? widget.item?.subtitle : null,
    );
    Navigator.of(context).pop(newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 16, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text(widget.item == null ? 'New Item' : 'Edit Item', style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textDark),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
            _buildTextField(label: 'Title', controller: _titleController),
            const SizedBox(height: 24),
            _buildSectionTitle('Type'),
            _buildChipGroup<ItemType>(
              options: ItemType.values,
              selectedOption: _selectedType,
              onSelected: (type) => setState(() => _selectedType = type),
              labelBuilder: (type) => (type as ItemType).name[0].toUpperCase() + (type as ItemType).name.substring(1),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Status'),
            _buildChoiceGroup<ItemStatus>(
              options: ItemStatus.values,
              selectedOption: _selectedStatus,
              onSelected: (status) => setState(() => _selectedStatus = status),
              labelBuilder: (status) {
                 switch (status as ItemStatus) {
                    case ItemStatus.toDo: return 'To Do';
                    case ItemStatus.doing: return 'Doing';
                    case ItemStatus.done: return 'Done';
                  }
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveItem,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save Item', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
             const SizedBox(height: 32),
          ],
        ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, color: AppColors.textGrey, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.borderGrey.withOpacity(0.5))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2)),
            hintText: 'Enter title',
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildChipGroup<T>({required List<T> options, required T selectedOption, required Function(T) onSelected, required String Function(T) labelBuilder}) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: options.map((option) {
        final isSelected = option == selectedOption;
        return ChoiceChip(
          label: Text(labelBuilder(option)),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              onSelected(option);
            }
          },
          backgroundColor: AppColors.surfaceWhite,
          selectedColor: AppColors.primaryBlue.withOpacity(0.1),
          labelStyle: TextStyle(color: isSelected ? AppColors.primaryBlue : AppColors.textDark, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: isSelected ? AppColors.primaryBlue : AppColors.borderGrey.withOpacity(0.5)),
          ),
        );
      }).toList(),
    );
  }

   Widget _buildChoiceGroup<T>({required List<T> options, required T selectedOption, required Function(T) onSelected, required String Function(T) labelBuilder}) {
    return Column(
      children: options.map((option) {
        final isSelected = option == selectedOption;
        return GestureDetector(
          onTap: () => onSelected(option),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryBlue.withOpacity(0.1) : AppColors.surfaceWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primaryBlue : AppColors.borderGrey.withOpacity(0.5),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  labelBuilder(option),
                  style: TextStyle(
                    color: isSelected ? AppColors.primaryBlue : AppColors.textDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check, color: AppColors.primaryBlue),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
