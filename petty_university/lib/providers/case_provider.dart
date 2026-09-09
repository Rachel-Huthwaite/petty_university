import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/case_entry.dart';

class CaseProvider extends ChangeNotifier {
  static const _storageKey = 'petty_university_cases';

  final List<CaseEntry> _cases = [];
  int _caseCounter = 0;

  List<CaseEntry> get cases => List.unmodifiable(_cases);

  List<CaseEntry> get openCases =>
      _cases.where((c) => c.status == CaseStatus.open).toList();

  List<CaseEntry> get closedCases =>
      _cases.where((c) => c.status == CaseStatus.closed).toList();

  String _nextCaseId() {
    _caseCounter += 1;
    return '##CASE${_caseCounter.toString().padLeft(3, '0')}';
  }

  CaseEntry addCase({String entryText = ''}) {
    final entry = CaseEntry(
      id: _nextCaseId(),
      status: CaseStatus.open,
      entryText: entryText,
      createdAt: DateTime.now(),
    );
    _cases.add(entry);
    notifyListeners();
    _saveToStorage();
    return entry;
  }

  void updateCase(String id, {required String entryText}) {
    final index = _cases.indexWhere((c) => c.id == id);
    if (index == -1) return;
    _cases[index] = _cases[index].copyWith(entryText: entryText);
    notifyListeners();
    _saveToStorage();
  }

  void closeCaseWithNeeds(
    String id, {
    required List<String> needs,
    String otherNeed = '',
  }) {
    final index = _cases.indexWhere((c) => c.id == id);
    if (index == -1) return;
    _cases[index] = _cases[index].copyWith(
      status: CaseStatus.closed,
      needs: needs,
      otherNeed: otherNeed,
    );
    notifyListeners();
    _saveToStorage();
  }

  void discardCase(String id) {
    _cases.removeWhere((c) => c.id == id);
    notifyListeners();
    _saveToStorage();
  }

  CaseEntry? getCase(String id) {
    try {
      return _cases.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }


  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return;

    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    _cases
      ..clear()
      ..addAll(decoded.map((e) => CaseEntry.fromJson(e as Map<String, dynamic>)));

    for (final c in _cases) {
      final numeric = int.tryParse(c.id.replaceAll(RegExp(r'[^0-9]'), ''));
      if (numeric != null && numeric > _caseCounter) {
        _caseCounter = numeric;
      }
    }

    notifyListeners();
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_cases.map((c) => c.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }
}
