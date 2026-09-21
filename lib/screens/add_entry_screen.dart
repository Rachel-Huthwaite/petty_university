import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/case_entry.dart';
import '../providers/case_provider.dart';
import '../theme/app_constants.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_container.dart';

class AddEntryScreenArgs {
  final String? caseId;
  final bool isReadOnly;

  const AddEntryScreenArgs({this.caseId, this.isReadOnly = false});
}

class AddEntryScreen extends StatefulWidget {
  final String? caseId;
  final bool isReadOnly;

  const AddEntryScreen({
    super.key,
    this.caseId,
    this.isReadOnly = false,
  });

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  late String _caseId;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final provider = context.read<CaseProvider>();

    if (widget.caseId == null) {
      // Brand-new entry — create the draft case now so there's an id to
      // work with. If the user Discards, this draft is removed entirely.
      final entry = provider.addCase();
      _caseId = entry.id;
    } else {
      _caseId = widget.caseId!;
    }

    final existing = provider.getCase(_caseId);
    _controller = TextEditingController(text: existing?.entryText ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final provider = context.read<CaseProvider>();
    provider.updateCase(_caseId, entryText: _controller.text);
    Navigator.pushNamed(context, '/unpack/prompt', arguments: _caseId);
  }

  void _exit() {
    final provider = context.read<CaseProvider>();
    provider.updateCase(_caseId, entryText: _controller.text);
    Navigator.pushReplacementNamed(context, '/cases');
  }

  void _discard() {
    final provider = context.read<CaseProvider>();
    provider.discardCase(_caseId);
    Navigator.pushReplacementNamed(context, '/cases');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isReadOnly) {
      return _buildReadOnlyView(context);
    }
    return _buildEditableView(context);
  }

  Widget _buildEditableView(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppConstants.wallpaperEntry, fit: BoxFit.cover),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, bottom: 4),
                  child: GlassContainer(
                    customBorderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppConstants.cornerRadius),
                      bottomRight: Radius.circular(AppConstants.cornerRadius),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      "Lets dive in, unpack the mess,\nget grounded,\nand mind our business.",
                      style: AppTheme.screenDescription,
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(_caseId, style: AppTheme.caseIdHeader),
                                  const SizedBox(width: 8),
                                  Text('- open', style: AppTheme.caseStatusOpenClosed),
                                ],
                              ),
                              _EntryMenuButton(
                                onSave: _save,
                                onExit: _exit,
                                onDiscard: _discard,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          Expanded(
                            child: TextField(
                              controller: _controller,
                              maxLines: null,
                              expands: true,
                              textAlignVertical: TextAlignVertical.top,
                              style: AppTheme.userInputText,
                              cursorColor: AppTheme.textPrimary,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Spill it...',
                                hintStyle: AppTheme.entryHintText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyView(BuildContext context) {
    final provider = context.watch<CaseProvider>();
    final entry = provider.getCase(_caseId);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppConstants.wallpaperEntry, fit: BoxFit.cover),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: _ExitButton(
                      onTap: () => Navigator.pushReplacementNamed(context, '/cases'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: SingleChildScrollView(
                      child: GlassContainer(
                        padding: const EdgeInsets.fromLTRB(28, 24, 20, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(_caseId, style: AppTheme.caseIdHeader),
                                const SizedBox(width: 8),
                                Text('- closed', style: AppTheme.caseStatusOpenClosed),
                              ],
                            ),
                            const SizedBox(height: 16),

                            Text(entry?.entryText ?? '', style: AppTheme.userInputText),
                            const SizedBox(height: 32),

                            if (entry != null) ...[
                              Text('I was needing:', style: AppTheme.caseIdHeader),
                              const SizedBox(height: 12),
                              ...entry.needs.map(
                                (need) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(need, style: AppTheme.needOptionLabel),
                                ),
                              ),
                              if (entry.otherNeed.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(entry.otherNeed, style: AppTheme.needOptionLabel),
                                ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryMenuButton extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onExit;
  final VoidCallback onDiscard;

  const _EntryMenuButton({
    required this.onSave,
    required this.onExit,
    required this.onDiscard,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Image.asset(AppConstants.iconMenu, width: 24, height: 24),
      color: const Color(0xFF1A1A26),
      onSelected: (value) {
        switch (value) {
          case 'save':
            onSave();
            break;
          case 'exit':
            onExit();
            break;
          case 'discard':
            onDiscard();
            break;
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'save', child: Text('Save')),
        PopupMenuItem(value: 'exit', child: Text('Exit')),
        PopupMenuItem(value: 'discard', child: Text('Discard')),
      ],
    );
  }
}

class _ExitButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ExitButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(AppConstants.iconExit, width: 28, height: 28),
        ),
      ),
    );
  }
}

