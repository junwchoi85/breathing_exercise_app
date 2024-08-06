class DatabaseSessionData {
  final int? id;
  final int sessionNumber;
  final int retentionTime;
  final int recoveryTime;
  final DateTime date;

  DatabaseSessionData({
    this.id,
    required this.sessionNumber,
    required this.retentionTime,
    required this.recoveryTime,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'sessionNumber': sessionNumber,
        'retentionTime': retentionTime,
        'recoveryTime': recoveryTime,
        'date': date.toIso8601String(),
      };

  static DatabaseSessionData fromJson(Map<String, dynamic> json) =>
      DatabaseSessionData(
        id: json['id'] as int?,
        sessionNumber: json['sessionNumber'] as int,
        retentionTime: json['retentionTime'] as int,
        recoveryTime: json['recoveryTime'] as int,
        date: DateTime.parse(json['date'] as String),
      );
}
