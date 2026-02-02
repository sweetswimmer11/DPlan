import 'dart:async';
import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'dart:math' as math;

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  static const int _totalTime = 25 * 60; // 25 minutes
  int _currentTime = _totalTime;
  Timer? _timer;
  bool _isRunning = false;
  int _sessionsCompleted = 0;
  final int _totalSessions = 4;

  void _startTimer() {
    if (_isRunning) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTime > 0) {
          _currentTime--;
        } else {
          _timer?.cancel();
          _isRunning = false;
          _sessionsCompleted++;
          _currentTime = _totalTime;
        }
      });
    });
    _isRunning = true;
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _currentTime = _totalTime;
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new, color: AppColors.textDark, size: 20),
        title: const Text('Focus', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        actions: const [
          Icon(Icons.settings, color: AppColors.textDark),
          SizedBox(width: 16),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            'DEEP FOCUS',
            style: TextStyle(
              color: AppColors.textGrey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 1.2,
            ),
          ),
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 280,
                    height: 280,
                    child: CustomPaint(
                      painter: TimerPainter(progress: _currentTime / _totalTime),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(_currentTime ~/ 60).toString().padLeft(2, '0')}:${(_currentTime % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'minutes',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Text(
            '$_sessionsCompleted of $_totalSessions sessions completed',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_totalSessions, (index) => _buildDot(index < _sessionsCompleted)),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: _isRunning ? _stopTimer : _startTimer,
                    icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow, color: Colors.white),
                    label: Text(_isRunning ? 'Pause Session' : 'Start Session', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
                      shadowColor: AppColors.accentPurple.withOpacity(0.4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: _resetTimer,
                    icon: const Icon(Icons.refresh, color: AppColors.textDark),
                    label: const Text('Reset', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0), style: BorderStyle.solid),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('DAILY GOAL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textGrey)),
                    Text('${(_sessionsCompleted / _totalSessions * 100).toInt()}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.accentPurple)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: _sessionsCompleted / _totalSessions,
                  backgroundColor: const Color(0xFFE2E8F0),
                  color: AppColors.accentPurple,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildDot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? AppColors.accentPurple : const Color(0xFFE2E8F0),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final double progress;

  TimerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Background Circle
    final bgPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;
    
    canvas.drawCircle(center, radius, bgPaint);

    // Progress Arc
    final progressPaint = Paint()
      ..color = AppColors.accentPurple
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * (1 - progress),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    final old = oldDelegate as TimerPainter;
    return old.progress != progress;
  }
}
