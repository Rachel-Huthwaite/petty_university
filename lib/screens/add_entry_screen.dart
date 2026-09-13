import 'package:flutter/material.dart';

class AddEntryScreenArgs {
  final String? caseId;
  final bool isReadOnly;

  const AddEntryScreenArgs({this.caseId, this.isReadOnly = false});
}

class AddEntryScreen extends StatelessWidget {
  final String? caseId;
  final bool isReadOnly;

  const AddEntryScreen({
    super.key,
    this.caseId,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final label = caseId == null
        ? 'New entry'
        : '${isReadOnly ? "Read-only" : "Editing"} — $caseId';

    return Scaffold(
      body: Center(
        child: Text('Add-Entry-Screen ($label) — TODO: Issues 3.1 / 3.2'),
      ),
    );
  }
}
