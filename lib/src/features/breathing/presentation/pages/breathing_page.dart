import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_state.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/pages/report_page.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/pages/retention_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreathingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Breathing Phase')),
      body: BlocListener<BreathingBloc, BreathingState>(
        listener: (context, state) {
          if (state is RetentionInProgress) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => RetentionPage()),
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
            if (state is BreathingInProgress) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Breaths Count: ${state.breathCount}',
                        style: TextStyle(fontSize: 24)),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<BreathingBloc>(context)
                            .add(StopSession());
                        Navigator.of(context).pop();
                      },
                      child: Text('Stop Session'),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
