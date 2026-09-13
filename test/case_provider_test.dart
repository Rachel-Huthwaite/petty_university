import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petty_university/models/case_entry.dart';
import 'package:petty_university/providers/case_provider.dart';

void main() {
  // CaseProvider writes to shared_preferences on every change. In a bare
  // unit test environment there's no real platform to talk to, so we mock
  // the plugin's storage with an empty in-memory map.
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('CaseProvider — ID generation', () {
    test('first case is ##CASE001', () {
      final provider = CaseProvider();
      final entry = provider.addCase(entryText: 'venting about the group chat');
      expect(entry.id, '##CASE001');
    });

    test('IDs increment correctly across multiple cases', () {
      final provider = CaseProvider();
      final first = provider.addCase(entryText: 'first');
      final second = provider.addCase(entryText: 'second');
      final third = provider.addCase(entryText: 'third');

      expect(first.id, '##CASE001');
      expect(second.id, '##CASE002');
      expect(third.id, '##CASE003');
    });
  });

  group('CaseProvider — status transitions', () {
    test('new cases start as open', () {
      final provider = CaseProvider();
      final entry = provider.addCase(entryText: 'test');
      expect(entry.status, CaseStatus.open);
      expect(provider.openCases.length, 1);
      expect(provider.closedCases.length, 0);
    });

    test('closeCaseWithNeeds flips status to closed and stores needs', () {
      final provider = CaseProvider();
      final entry = provider.addCase(entryText: 'test');

      provider.closeCaseWithNeeds(
        entry.id,
        needs: ['Basic Respect', 'A Moment to Breath'],
        otherNeed: 'A snack, honestly',
      );

      final updated = provider.getCase(entry.id);
      expect(updated, isNotNull);
      expect(updated!.status, CaseStatus.closed);
      expect(updated.needs, ['Basic Respect', 'A Moment to Breath']);
      expect(updated.otherNeed, 'A snack, honestly');
      expect(provider.openCases.length, 0);
      expect(provider.closedCases.length, 1);
    });

    test('updateCase changes entry text without affecting status', () {
      final provider = CaseProvider();
      final entry = provider.addCase(entryText: 'original text');

      provider.updateCase(entry.id, entryText: 'edited text');

      final updated = provider.getCase(entry.id);
      expect(updated!.entryText, 'edited text');
      expect(updated.status, CaseStatus.open);
    });

    test('discardCase removes the entry entirely', () {
      final provider = CaseProvider();
      final entry = provider.addCase(entryText: 'to be discarded');

      provider.discardCase(entry.id);

      expect(provider.getCase(entry.id), isNull);
      expect(provider.cases.length, 0);
    });
  });

  group('CaseEntry — JSON round-trip', () {
    test('toJson/fromJson preserves all fields', () {
      final original = CaseEntry(
        id: '##CASE007',
        status: CaseStatus.closed,
        entryText: 'they used my mug again',
        createdAt: DateTime(2026, 9, 9, 12, 0),
        needs: const ['Clear Boundaries', 'Validation'],
        otherNeed: 'For everyone to just label their stuff',
      );

      final restored = CaseEntry.fromJson(original.toJson());

      expect(restored.id, original.id);
      expect(restored.status, original.status);
      expect(restored.entryText, original.entryText);
      expect(restored.createdAt, original.createdAt);
      expect(restored.needs, original.needs);
      expect(restored.otherNeed, original.otherNeed);
    });

    test('fromJson handles a missing "needs" list gracefully', () {
      final json = {
        'id': '##CASE001',
        'status': 'open',
        'entryText': 'quick vent',
        'createdAt': DateTime(2026, 1, 1).toIso8601String(),
      };

      final restored = CaseEntry.fromJson(json);

      expect(restored.needs, isEmpty);
      expect(restored.otherNeed, '');
    });
  });
}
