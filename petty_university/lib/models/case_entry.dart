enum CaseStatus { open, closed }

class CaseEntry {
  final String id; // e.g. "##CASE001"
  final CaseStatus status;
  final String entryText;
  final DateTime createdAt;
  final List<String> needs; 
  final String otherNeed; 

  const CaseEntry({
    required this.id,
    required this.status,
    required this.entryText,
    required this.createdAt,
    this.needs = const [],
    this.otherNeed = '',
  });

  CaseEntry copyWith({
    String? id,
    CaseStatus? status,
    String? entryText,
    DateTime? createdAt,
    List<String>? needs,
    String? otherNeed,
  }) {
    return CaseEntry(
      id: id ?? this.id,
      status: status ?? this.status,
      entryText: entryText ?? this.entryText,
      createdAt: createdAt ?? this.createdAt,
      needs: needs ?? this.needs,
      otherNeed: otherNeed ?? this.otherNeed,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status.name,
        'entryText': entryText,
        'createdAt': createdAt.toIso8601String(),
        'needs': needs,
        'otherNeed': otherNeed,
      };

  factory CaseEntry.fromJson(Map<String, dynamic> json) {
    return CaseEntry(
      id: json['id'] as String,
      status: CaseStatus.values.byName(json['status'] as String),
      entryText: json['entryText'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      needs: List<String>.from(json['needs'] as List? ?? []),
      otherNeed: json['otherNeed'] as String? ?? '',
    );
  }
}
