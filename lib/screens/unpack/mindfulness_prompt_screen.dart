import 'package:flutter/material.dart';

import '../../theme/app_constants.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/pill_button.dart';


class MindfulnessPromptScreen extends StatelessWidget {
  const MindfulnessPromptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppConstants.wallpaperUnpack, fit: BoxFit.cover),

          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GlassContainer(
                  padding: const EdgeInsets.fromLTRB(28, 24, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'You called out the need.\nNow drop the tension.',
                        style: AppTheme.mindfulnessStatement,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Take 2 minutes to breathe\nbefore you go back out there?',
                        style: AppTheme.mindfulnessQuestion,
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PillButton(
                            label: "Let's Ground",
                            labelStyle: AppTheme.smallButtonLabel,
                            color: AppTheme.accentGreen,
                            width: 150,
                            onTap: () {
                              Navigator.pushNamed(context, '/mindfulness/timer');
                            },
                          ),
                          PillButton(
                            label: "I'll pass",
                            labelStyle: AppTheme.smallButtonLabel,
                            color: AppTheme.accentPurple,
                            width: 120,
                            onTap: () {
                              // Case is already closed with its needs —
                              // nothing left to do but head back.
                              Navigator.pushReplacementNamed(context, '/cases');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
