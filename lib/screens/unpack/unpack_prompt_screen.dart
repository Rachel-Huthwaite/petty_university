import 'package:flutter/material.dart';

import '../../theme/app_constants.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/image_button.dart';


class UnpackPromptScreen extends StatelessWidget {
  const UnpackPromptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final caseId = ModalRoute.of(context)!.settings.arguments as String;

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("That's a lot of noise!", style: AppTheme.unpackStatement),
                      const SizedBox(height: 8),
                      Text('Are we unpacking this?', style: AppTheme.unpackQuestion),
                      const SizedBox(height: 4),
                      Text(
                        '(or leaving it sitting in the hallway?...)',
                        style: AppTheme.unpackSubtext,
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ImageButton(
                            assetPath: AppConstants.btnUnpack,
                            label: 'Unpack',
                            labelStyle: AppTheme.unpackButtonLabel,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/unpack/name-need',
                                arguments: caseId,
                              );
                            },
                          ),
                          ImageButton(
                            assetPath: AppConstants.btnLater,
                            label: 'Later',
                            labelStyle: AppTheme.unpackButtonLabel,
                            onTap: () {
                              // Case stays open — no provider change needed,
                              // it was already left open by the entry screen.
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
