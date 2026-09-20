import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/case_provider.dart';
import '../../theme/app_constants.dart';
import '../../theme/app_theme.dart';
import '../../widgets/pill_button.dart';

class SelectNeedsScreen extends StatefulWidget {
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
  State<SelectNeedsScreen> createState() => _SelectNeedsScreenState();
}

class _SelectNeedsScreenState extends State<SelectNeedsScreen> {
  final Set<String> _selected = {};
  final TextEditingController _otherController = TextEditingController();

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  void _toggle(String need) {
    setState(() {
      if (_selected.contains(need)) {
        _selected.remove(need);
      } else {
        _selected.add(need);
      }
    });
  }

  void _lockIn(String caseId) {
    context.read<CaseProvider>().closeCaseWithNeeds(
          caseId,
          needs: _selected.toList(),
          otherNeed: _otherController.text.trim(),
        );
    Navigator.pushNamed(context, '/unpack/mindfulness-prompt');
  }

  @override
  Widget build(BuildContext context) {
    final caseId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppConstants.wallpaperUnpack, fit: BoxFit.cover),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The petty details are loud but the unmet\nneed is real. Lets call it out',
                      style: AppTheme.screenDescription,
                    ),
                    const SizedBox(height: 24),

                    ...SelectNeedsScreen.presetNeeds.map(
                      (need) => _NeedCheckboxRow(
                        label: need,
                        selected: _selected.contains(need),
                        onTap: () => _toggle(need),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text('Other:', style: AppTheme.otherFieldLabel),
                    const SizedBox(height: 4),
                    Text(
                      'Type what you were actually needing here…',
                      style: AppTheme.otherFieldHint,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        controller: _otherController,
                        maxLines: 3,
                        style: AppTheme.userInputText,
                        cursorColor: AppTheme.textPrimary,
                        decoration: const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(height: 28),

                    Center(
                      child: PillButton(
                        label: 'Lock In Need & Reframe',
                        labelStyle: AppTheme.smallButtonLabel,
                        color: AppTheme.accentGreen,
                        width: 220,
                        onTap: () => _lockIn(caseId),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NeedCheckboxRow extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NeedCheckboxRow({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.textPrimary, width: 1.5),
                color: selected ? AppTheme.accentGreen : Colors.transparent,
              ),
              child: selected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(label, style: AppTheme.needOptionLabel),
          ],
        ),
      ),
    );
  }
}
