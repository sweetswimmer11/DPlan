import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';

class ChecklistDetailScreen extends StatelessWidget {
  const ChecklistDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Travel Essentials', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildCheckItem('Pack universal power adapter'),
                const SizedBox(height: 8),
                _buildCheckItem('Confirm hotel reservation'),
                const SizedBox(height: 8),
                _buildCheckItem('Download offline maps'),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('COMPLETED (3)', style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    const Text('Hide', style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 12),
                Opacity(
                  opacity: 0.6,
                  child: Column(
                    children: [
                      _buildCheckItem('Renew passport', isChecked: true),
                      const SizedBox(height: 8),
                      _buildCheckItem('Book flight tickets', isChecked: true),
                      const SizedBox(height: 8),
                      _buildCheckItem('Buy travel insurance', isChecked: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              border: const Border(top: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.add, color: AppColors.textLightGrey),
                          SizedBox(width: 12),
                          Text('Add a new item...', style: TextStyle(color: AppColors.textLightGrey)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_upward, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text, {bool isChecked = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isChecked ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isChecked ? const Border(bottom: BorderSide(color: Color(0xFFE2E8F0))) : Border.all(color: Colors.transparent),
        boxShadow: isChecked ? [] : [
           BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check_box : Icons.check_box_outline_blank,
            color: AppColors.primaryPurple,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isChecked ? FontWeight.normal : FontWeight.w500,
                decoration: isChecked ? TextDecoration.lineThrough : null,
                color: isChecked ? AppColors.textDark : AppColors.textDark,
              ),
            ),
          ),
          if (!isChecked) ...[
            const Icon(Icons.delete_outline, color: AppColors.textLightGrey),
            const SizedBox(width: 12),
            const Icon(Icons.drag_indicator, color: AppColors.textLightGrey),
          ],
        ],
      ),
    );
  }
}
