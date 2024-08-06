import 'package:breathing_exercise_app/src/features/wimhof_breathing/view/breathing_timer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Breathing Exercise App!',
            ),
            const SizedBox(height: 20),
            // Add a button to navigate to the WimhofBreathingScreen
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BreathingTimer()));
              },
              child: const Text('Wimhof Breathing'),
            ),
          ],
        ),
      ),
    );
  }
}
