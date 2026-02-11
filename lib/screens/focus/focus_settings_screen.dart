
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';

class FocusSettingsScreen extends StatefulWidget {
  final Duration initialFocusDuration;
  final Duration initialBreakDuration;
  final bool initialAutoStartBreaks;
  final bool initialAutoStartFocus;

  const FocusSettingsScreen({
    super.key,
    required this.initialFocusDuration,
    required this.initialBreakDuration,
    required this.initialAutoStartBreaks,
    required this.initialAutoStartFocus,
  });

  @override
  State<FocusSettingsScreen> createState() => _FocusSettingsScreenState();
}

class _FocusSettingsScreenState extends State<FocusSettingsScreen> {
  late Duration _focusDuration;
  late Duration _breakDuration;
  late bool _autoStartBreaks;
  late bool _autoStartFocus;

  @override
  void initState() {
    super.initState();
    _focusDuration = widget.initialFocusDuration;
    _breakDuration = widget.initialBreakDuration;
    _autoStartBreaks = widget.initialAutoStartBreaks;
    _autoStartFocus = widget.initialAutoStartFocus;
  }

  void _showDurationPicker(BuildContext context, {required bool isFocusDuration}) {
    final initialDuration = isFocusDuration ? _focusDuration : _breakDuration;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: 250,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.ms,
            initialTimerDuration: initialDuration,
            onTimerDurationChanged: (Duration newDuration) {
              setState(() {
                if (isFocusDuration) {
                  _focusDuration = newDuration;
                } else {
                  _breakDuration = newDuration;
                }
              });
            },
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
  
  void _saveSettings() {
    Navigator.pop(context, {
      'focusDuration': _focusDuration,
      'breakDuration': _breakDuration,
      'autoStartBreaks': _autoStartBreaks,
      'autoStartFocus': _autoStartFocus,
    });
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
        title: const Text('Settings', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveSettings,
            child: const Text('Done', style: TextStyle(color: AppColors.primaryBlue, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('FOCUS DURATION'),
          _buildDurationSelector(context, _focusDuration, isFocusDuration: true),
          const SizedBox(height: 32),
          _buildSectionTitle('BREAK DURATION'),
          _buildDurationSelector(context, _breakDuration, isFocusDuration: false),
          const SizedBox(height: 32),
          _buildToggleSetting(
            title: 'Auto-start Breaks',
            value: _autoStartBreaks,
            onChanged: (bool value) {
              setState(() {
                _autoStartBreaks = value;
              });
            },
          ),
          const Divider(height: 1, color: AppColors.borderGrey),
          _buildToggleSetting(
            title: 'Auto-start Focus',
            value: _autoStartFocus,
            onChanged: (bool value) {
              setState(() {
                _autoStartFocus = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Padding _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(color: AppColors.textGrey, letterSpacing: 1.1, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildDurationSelector(BuildContext context, Duration duration, {required bool isFocusDuration}) {
    return GestureDetector(
      onTap: () => _showDurationPicker(context, isFocusDuration: isFocusDuration),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 24),
         decoration: BoxDecoration(
            color: AppColors.surfaceWhite,
            borderRadius: BorderRadius.circular(16),
             border: Border.all(color: AppColors.borderGrey.withOpacity(0.5))
          ),
        child: Text(
          _formatDuration(duration),
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w300, color: AppColors.textDark),
        ),
      ),
    );
  }

  Widget _buildToggleSetting({required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(title, style: const TextStyle(fontSize: 16, color: AppColors.textDark)),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryBlue,
      ),
       // Add a bottom border
      shape: const Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5)),
    );
  }
}
