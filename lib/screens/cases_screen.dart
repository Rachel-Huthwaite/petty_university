import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/case_entry.dart';
import '../providers/case_provider.dart';
import '../theme/app_constants.dart';
import '../theme/app_theme.dart';
import 'add_entry_screen.dart';


class CasesScreen extends StatefulWidget {
  const CasesScreen({super.key});

  @override
  State<CasesScreen> createState() => _CasesScreenState();
}

enum _CaseFilter { all, open, closed }

class _CasesScreenState extends State<CasesScreen> {
  _CaseFilter _filter = _CaseFilter.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppConstants.wallpaperCases, fit: BoxFit.cover),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "A record of every time the noise tried to win\n(and you unpacked it instead...hopefully)",
                    style: AppTheme.screenDescription,
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('CLASSIFIED RECEIPTS', style: AppTheme.classifiedReceiptsHeader),
                      _MenuButton(
                        onOpenCase: _createNewCase,
                        onFilterSelected: (f) => setState(() => _filter = f),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: Consumer<CaseProvider>(
                      builder: (context, provider, _) {
                        final cases = _filteredCases(provider);

                        if (cases.isEmpty) {
                          return Text(
                            provider.cases.isEmpty
                                ? 'No cases yet.'
                                : 'No cases match this filter.',
                            style: AppTheme.caseListStatus,
                          );
                        }

                        return ListView.separated(
                          itemCount: cases.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final entry = cases[index];
                            return _CaseListTile(
                              entry: entry,
                              onTap: () => _openCase(entry),
                            );
                          },
                        );
                      },
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

  List<CaseEntry> _filteredCases(CaseProvider provider) {
    switch (_filter) {
      case _CaseFilter.open:
        return provider.openCases;
      case _CaseFilter.closed:
        return provider.closedCases;
      case _CaseFilter.all:
        return provider.cases;
    }
  }

  void _createNewCase() {
    final provider = context.read<CaseProvider>();
    final entry = provider.addCase();
    Navigator.pushNamed(
      context,
      '/entry',
      arguments: AddEntryScreenArgs(caseId: entry.id, isReadOnly: false),
    );
  }

  void _openCase(CaseEntry entry) {
    Navigator.pushNamed(
      context,
      '/entry',
      arguments: AddEntryScreenArgs(
        caseId: entry.id,
        isReadOnly: entry.status == CaseStatus.closed,
      ),
    );
  }
}

class _CaseListTile extends StatelessWidget {
  final CaseEntry entry;
  final VoidCallback onTap;

  const _CaseListTile({required this.entry, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final statusLabel = entry.status == CaseStatus.open ? 'OPEN' : 'CLOSED';

    return Material(
      color: Colors.black.withOpacity(0.35),
      borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Text(entry.id, style: AppTheme.caseListId),
              const SizedBox(width: 8),
              Text('- $statusLabel', style: AppTheme.caseListStatus),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final VoidCallback onOpenCase;
  final ValueChanged<_CaseFilter> onFilterSelected;

  const _MenuButton({required this.onOpenCase, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Image.asset(AppConstants.iconMenu, width: 24, height: 24),
      color: const Color(0xFF1A1A26),
      onSelected: (value) {
        switch (value) {
          case 'open_case':
            onOpenCase();
            break;
          case 'filter_all':
            onFilterSelected(_CaseFilter.all);
            break;
          case 'filter_open':
            onFilterSelected(_CaseFilter.open);
            break;
          case 'filter_closed':
            onFilterSelected(_CaseFilter.closed);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'open_case', child: Text('Open Case')),
        const PopupMenuDivider(),
        const PopupMenuItem(value: 'filter_all', child: Text('Filter: All')),
        const PopupMenuItem(value: 'filter_open', child: Text('Filter: Open')),
        const PopupMenuItem(value: 'filter_closed', child: Text('Filter: Closed')),
      ],
    );
  }
}
