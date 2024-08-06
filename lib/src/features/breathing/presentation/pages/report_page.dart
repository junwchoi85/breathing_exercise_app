import 'package:breathing_exercise_app/src/features/breathing/data/database.dart';
import 'package:breathing_exercise_app/src/features/breathing/data/models/session_data.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  final List<BreathingSessionData> sessionDataList;

  const ReportPage({super.key, required this.sessionDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Session Report')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Sessions: ${sessionDataList.length}',
                  style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Session')),
                    DataColumn(label: Text('Retention Time')),
                    DataColumn(label: Text('Recovery Time')),
                  ],
                  rows: sessionDataList.map((sessionData) {
                    return DataRow(cells: [
                      DataCell(Text('${sessionData.sessionNumber}')),
                      DataCell(Text('${sessionData.retentionTime} seconds')),
                      DataCell(Text('${sessionData.recoveryTime} seconds')),
                    ]);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    for (var session in sessionDataList) {
                      var dbSession = DatabaseSessionData(
                        sessionNumber: session.sessionNumber,
                        retentionTime: session.retentionTime,
                        recoveryTime: session.recoveryTime,
                        date: session.date,
                      );
                      await DatabaseHelper.instance.insertSession(dbSession);
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
