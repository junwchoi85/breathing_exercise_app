import 'package:breathing_exercise_app/src/features/breathing/domain/entities/breathing_session.dart';
import 'package:equatable/equatable.dart';

abstract class BreathingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartSession extends BreathingEvent {
  StartSession({required this.session});

  final BreathingSession session;

  @override
  List<Object> get props => [session];
}

class StopSession extends BreathingEvent {}
