
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/screens/focus/focus_settings_screen.dart';

enum FocusState { idle, focusing, resting }

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  FocusState _currentState = FocusState.idle;
  Timer? _timer;
  Duration _focusDuration = const Duration(minutes: 25);
  Duration _breakDuration = const Duration(minutes: 5);
  late Duration _timeRemaining;
  bool _autoStartBreaks = false;
  bool _autoStartFocus = true;

  @override
  void initState() {
    super.initState();
    _timeRemaining = _focusDuration;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _currentState = _currentState == FocusState.idle ? FocusState.focusing : _currentState;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining.inSeconds > 0) {
        setState(() {
          _timeRemaining = _timeRemaining - const Duration(seconds: 1);
        });
      } else {
        _timer?.cancel();
        _handleTimerCompletion();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {});
  }

   void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _currentState = FocusState.idle;
      _timeRemaining = _focusDuration;
    });
  }
  
  void _handleTimerCompletion() {
    if (_currentState == FocusState.focusing) {
      setState(() {
        _currentState = FocusState.resting;
        _timeRemaining = _breakDuration;
      });
      if (_autoStartBreaks) _startTimer();
    } else if (_currentState == FocusState.resting) {
      setState(() {
        _currentState = FocusState.idle;
        _timeRemaining = _focusDuration;
      });
       if (_autoStartFocus) _startTimer();
    }
  }

   void _skipBreak() {
    _timer?.cancel();
    setState(() {
      _currentState = FocusState.idle;
      _timeRemaining = _focusDuration;
    });
  }

  void _extendBreak() {
    setState(() {
      _timeRemaining += const Duration(minutes: 5);
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void _navigateToSettings() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => FocusSettingsScreen(
          initialFocusDuration: _focusDuration,
          initialBreakDuration: _breakDuration,
          initialAutoStartBreaks: _autoStartBreaks,
          initialAutoStartFocus: _autoStartFocus,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _focusDuration = result['focusDuration'];
        _breakDuration = result['breakDuration'];
        _autoStartBreaks = result['autoStartBreaks'];
        _autoStartFocus = result['autoStartFocus'];
        if (_currentState == FocusState.idle) {
           _timeRemaining = _focusDuration;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentState == FocusState.resting ? AppColors.successGreen.withOpacity(0.05) : AppColors.backgroundWhite,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: _currentState == FocusState.idle
          ? IconButton(icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark), onPressed: () => Navigator.of(context).pop())
          : null,
      title: _currentState != FocusState.idle
          ? Text(
              _currentState == FocusState.focusing ? 'FOCUS MODE' : 'RESTING',
              style: TextStyle(color: _currentState == FocusState.focusing ? AppColors.primaryBlue: AppColors.successGreen, letterSpacing: 1.1, fontWeight: FontWeight.w600),
            )
          : const Text(
              'Focus',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.textDark),
            ),
       actions: [
        if (_currentState == FocusState.idle) 
          IconButton(
            icon: const Icon(LucideIcons.barChartHorizontal, color: AppColors.textDark),
            onPressed: _navigateToSettings, 
          )
        else 
          IconButton(
            icon: const Icon(LucideIcons.moreHorizontal, color: AppColors.textDark),
            onPressed: () {}, 
          ),
         const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildBody() {
    switch (_currentState) {
      case FocusState.focusing:
        return _buildFocusingView();
      case FocusState.resting:
        return _buildRestingView();
      default:
        return _buildIdleView();
    }
  }

  Widget _buildIdleView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(_formatDuration(_timeRemaining), style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w300, color: AppColors.textDark)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Select Task', style: TextStyle(fontSize: 16, color: AppColors.textGrey)), Icon(Icons.arrow_drop_down, color: AppColors.textGrey)],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [ 
              TextButton.icon(onPressed: (){}, icon: const Icon(LucideIcons.bellOff, color: AppColors.textGrey), label: const Text('QUIET', style: TextStyle(color: AppColors.textGrey))),
              TextButton.icon(onPressed: (){}, icon: const Icon(LucideIcons.wind, color: AppColors.textGrey), label: const Text('FLOW', style: TextStyle(color: AppColors.textGrey)))
            ],
          ),
           const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: ElevatedButton.icon(
              onPressed: _startTimer,
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              label: const Text('Start Focus', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Text(_formatDuration(_timeRemaining), style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w300, color: AppColors.textDark)),
        const SizedBox(height: 10),
        const Text('Designing UI', style: TextStyle(fontSize: 18, color: AppColors.textDark, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: const Text('ACTIVE', style: TextStyle(color: AppColors.primaryBlue, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _timer!.isActive ? _pauseTimer : _startTimer,
                  icon: Icon(_timer!.isActive ? Icons.pause : Icons.play_arrow, color: AppColors.textDark),
                  label: Text(_timer!.isActive ? 'Pause' : 'Resume', style: const TextStyle(fontSize: 16, color: AppColors.textDark, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 60),
                    side: BorderSide(color: AppColors.borderGrey.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
               Expanded(
                child: TextButton.icon(
                  onPressed: _stopTimer,
                  icon: const Icon(Icons.stop, color: AppColors.errorRed),
                  label: const Text('Stop', style: TextStyle(fontSize: 16, color: AppColors.errorRed, fontWeight: FontWeight.bold)),
                   style: TextButton.styleFrom(
                    backgroundColor: AppColors.errorRed.withOpacity(0.1),
                    minimumSize: const Size(0, 60),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRestingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Text(_formatDuration(_timeRemaining), style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w300, color: AppColors.textDark)),
        const SizedBox(height: 10),
        const Text('Take a Breath', style: TextStyle(fontSize: 18, color: AppColors.textDark, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
         Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(color: AppColors.successGreen.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
          child: const Text('SHORT BREAK', style: TextStyle(color: AppColors.successGreen, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _skipBreak,
                  child: const Text('Skip Break', style: TextStyle(fontSize: 16, color: AppColors.textDark, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 60),
                    side: BorderSide(color: AppColors.borderGrey.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
               Expanded(
                child: OutlinedButton(
                  onPressed: _extendBreak,
                  child: const Text('Extend +5m', style: TextStyle(fontSize: 16, color: AppColors.textDark, fontWeight: FontWeight.bold)),
                   style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 60),
                    side: BorderSide(color: AppColors.borderGrey.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
