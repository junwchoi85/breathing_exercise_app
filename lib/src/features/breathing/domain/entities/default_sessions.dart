import 'package:breathing_exercise_app/src/features/breathing/domain/entities/breathing_session.dart';

final List<BreathingSession> defaultSessions = [
  BreathingSession(
    breaths: 5,
    retentionTime: 3,
    recoveryTime: 3,
    repetitions: 1,
  ),
  // BreathingSession(
  //   breaths: 30,
  //   retentionTime: 120,
  //   recoveryTime: 15,
  //   repetitions: 2,
  // ),
  // BreathingSession(
  //   breaths: 30,
  //   retentionTime: 180,
  //   recoveryTime: 15,
  //   repetitions: 3,
  // ),
];
