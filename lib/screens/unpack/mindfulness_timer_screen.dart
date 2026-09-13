import 'package:flutter/material.dart';

class MindfulnessTimerScreen extends StatefulWidget {
  const MindfulnessTimerScreen({super.key});

  @override
  State<MindfulnessTimerScreen> createState() => _MindfulnessTimerScreenState();
}

class _MindfulnessTimerScreenState extends State<MindfulnessTimerScreen> {


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Mindfulness Timer — TODO:')),
    );
  }
}
