import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_state.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/pages/recovery_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RetentionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Retention Phase')),
      body: BlocListener<BreathingBloc, BreathingState>(
        listener: (context, state) {
          if (state is RecoveryInProgress) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => RecoveryPage()),
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
