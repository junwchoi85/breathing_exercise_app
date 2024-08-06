import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_state.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/pages/recovery_page.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/pages/report_page.dart';

class RetentionPage extends StatelessWidget {
  const RetentionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retention Phase')),
      body: BlocListener<BreathingBloc, BreathingState>(
        listener: (context, state) {
          if (state is RecoveryInProgress) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => RecoveryPage()),
            );
          } else if (state is BreathingStopped) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) =>
                      ReportPage(sessionDataList: state.sessionDataList)),
            );
          }
        },
        child: BlocBuilder<BreathingBloc, BreathingState>(
          builder: (context, state) {
            if (state is RetentionInProgress) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Retention Time: ${state.elapsedSeconds} seconds',
                        style: const TextStyle(fontSize: 24)),
                    CircularProgressIndicator(
                      value: state.elapsedSeconds / state.session.retentionTime,
                      strokeWidth: 8,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<BreathingBloc>(context)
                            .add(StopSession());
                        Navigator.of(context).pop();
                      },
                      child: const Text('Stop Session'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
