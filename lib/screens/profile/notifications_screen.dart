
import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _pushNotifications = true;
  bool _emailReminders = false;
  bool _taskDeadlines = true;
  bool _focusSessionEnd = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text('Notifications', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Text(
                'ALERT SETTINGS',
                style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.1),
              ),
              const SizedBox(height: 16),
              _buildNotificationSwitch(
                  'Push Notifications',
                  'Main alerts for activity',
                  _pushNotifications, (value) => setState(() => _pushNotifications = value)),
               _buildNotificationSwitch(
                  'Email Reminders',
                  'Weekly digest and updates',
                  _emailReminders, (value) => setState(() => _emailReminders = value)),
               _buildNotificationSwitch(
                  'Task Deadlines',
                  'Reminders before tasks end',
                  _taskDeadlines, (value) => setState(() => _taskDeadlines = value)),
               _buildNotificationSwitch(
                  'Focus Session End',
                  'Alert when focus time is up',
                  _focusSessionEnd, (value) => setState(() => _focusSessionEnd = value)),

              const SizedBox(height: 32),

               const Text(
                'Customize how and when you receive alerts from D-Plan. These settings only affect the current device.',
                style: TextStyle(fontSize: 14, color: AppColors.textGrey),
              ),
               const SizedBox(height: 100),
               const Center(
                 child: Text(
                  'D-PLAN V2.4.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textGrey, fontSize: 12, letterSpacing: 1.2),
                               ),
               ),
            ],
          ),
        ),
    );
  }

  Widget _buildNotificationSwitch(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textGrey)),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryBlue,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    );
  }
}
