import 'dart:async';
import 'package:flutter/material.dart';

import '../../theme/app_constants.dart';
import '../../theme/app_theme.dart';

/// Built in Issue 4.2 — Mindfulness Timer (2-minute countdown).
class MindfulnessTimerScreen extends StatefulWidget {
  const MindfulnessTimerScreen({super.key});

  @override
  State<MindfulnessTimerScreen> createState() => _MindfulnessTimerScreenState();
}

class _MindfulnessTimerScreenState extends State<MindfulnessTimerScreen> {
  late int _secondsRemaining;
  Timer? _timer;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = AppConstants.mindfulnessDuration.inSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsRemaining <= 1) {
        setState(() {
          _secondsRemaining = 0;
          _isComplete = true;
        });
        _timer?.cancel();
      } else {
        setState(() => _secondsRemaining -= 1);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _leave() {
    _timer?.cancel();
    Navigator.pushReplacementNamed(context, '/cases');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppConstants.wallpaperTimer, fit: BoxFit.cover),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: _CloseButton(onTap: _leave),
                  ),
                  const Spacer(),
                  _isComplete ? _ResetCompleteCard(onTap: _leave) : _CountdownCard(time: _formattedTime),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CloseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.35),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.close, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class _CountdownCard extends StatelessWidget {
  final String time;

  const _CountdownCard({required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
      ),
      child: Text(time, style: AppTheme.timerDisplay),
    );
  }
}

class _ResetCompleteCard extends StatelessWidget {
  final VoidCallback onTap;

  const _ResetCompleteCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        decoration: BoxDecoration(
          color: AppTheme.accentPurple.withOpacity(0.55),
          borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Reset Complete', style: AppTheme.resetComplete),
            const SizedBox(height: 6),
            Text('Go mind your business', style: AppTheme.resetCompleteSubtext),
          ],
        ),
      ),
    );
  }
}

