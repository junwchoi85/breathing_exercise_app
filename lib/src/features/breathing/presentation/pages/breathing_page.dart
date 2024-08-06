import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_state.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/pages/report_page.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/pages/retention_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreathingPage extends StatelessWidget {
  const BreathingPage({super.key});

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
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(seconds: 1),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Icon(Icons.air, size: 100, color: Colors.blue),
                        );
                      },
                    ),
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
