import 'package:flutter/material.dart';

import '../../theme/app_constants.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/pill_button.dart';

/// Built in Issue 3.3 — Unpack Model (second): "Name the Need".
///
/// Expects the caseId as the route arguments (a plain String), carried
/// forward from UnpackPromptScreen.
class NameNeedScreen extends StatelessWidget {
  const NameNeedScreen({super.key});

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
                  padding: const EdgeInsets.fromLTRB(28, 24, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Lets cut the noise. Strip away\nthe petty details',
                        style: AppTheme.unpackStatement,
                      ),
                      const SizedBox(height: 12),
                      Text('what did you actually need?', style: AppTheme.unpackQuestion),
                      const SizedBox(height: 20),

                      Center(
                        child: PillButton(
                          label: 'Name the Need',
                          labelStyle: AppTheme.smallButtonLabel,
                          color: AppTheme.accentGreen,
                          width: 180,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/unpack/select-needs',
                              arguments: caseId,
                            );
                          },
                        ),
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

