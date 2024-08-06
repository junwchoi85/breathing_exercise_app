import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecoveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recovery Phase')),
      body: BlocListener<BreathingBloc, BreathingState>(
        listener: (context, state) {
          if (state is BreathingStopped) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        child: BlocBuilder<BreathingBloc, BreathingState>(
          builder: (context, state) {
            if (state is RecoveryInProgress) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Recovery Time: ${state.elapsedSeconds} seconds',
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
