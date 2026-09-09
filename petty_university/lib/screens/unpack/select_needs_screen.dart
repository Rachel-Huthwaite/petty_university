import 'package:flutter/material.dart';

class SelectNeedsScreen extends StatelessWidget {
  const SelectNeedsScreen({super.key});

  static const List<String> presetNeeds = [
    'Clear Boundaries',
    'Basic Respect',
    'Emotional Distance',
    'Space to be heard',
    'Validation',
    'A little Empathy',
    'An Actual Apology',
    'A Moment to Breath',
    'Less Drama',
    'Snack and a nap',
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Select Needs — TODO: Issue 3.3')),
    );
  }
}
