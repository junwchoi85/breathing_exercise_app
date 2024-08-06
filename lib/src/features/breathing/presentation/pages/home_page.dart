import 'package:breathing_exercise_app/src/features/breathing/domain/entities/default_sessions.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/pages/breathing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isCountdown = false;
  int _countdown = 3;

  void _startCountdown() {
    setState(() {
      _isCountdown = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _countdown--;
        });

        if (_countdown > 0) {
          _startCountdown();
        } else {
          context
              .read<BreathingBloc>()
              .add(StartSession(session: defaultSessions[0]));

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BreathingPage(),
            ),
          );
          // reset countdown
          setState(() {
            _isCountdown = false;
            _countdown = 3;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wim Hof Breathing')),
      body: Center(
        child: _isCountdown
            ? Text(
                'Starting in $_countdown',
                style: const TextStyle(fontSize: 24),
              )
            : ElevatedButton(
                onPressed: _startCountdown,
                child: const Text('Start Breathing Session'),
              ),
      ),
    );
  }
}
