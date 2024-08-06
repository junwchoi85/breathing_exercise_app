import 'package:breathing_exercise_app/src/features/breathing/domain/entities/breathing_session.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class BreathingState extends Equatable {
  @override
  List<Object> get props => [];
}

class BreathingInitial extends BreathingState {}

class BreathingInProgress extends BreathingState {
  final BreathingSession session;
  final int breathCount;

  BreathingInProgress({required this.session, required this.breathCount});

  @override
  List<Object> get props => [session, breathCount];
}

class RetentionInProgress extends BreathingState {
  final BreathingSession session;
  final int elapsedSeconds;

  RetentionInProgress({required this.session, required this.elapsedSeconds});

  @override
  List<Object> get props => [session, elapsedSeconds];
}

class RecoveryInProgress extends BreathingState {
  final BreathingSession session;
  final int elapsedSeconds;

  RecoveryInProgress({required this.session, required this.elapsedSeconds});

  @override
  List<Object> get props => [session, elapsedSeconds];
}

class BreathingStopped extends BreathingState {
  final List<SessionData> sessionDataList;

  BreathingStopped({required this.sessionDataList});

  @override
  List<Object> get props => [sessionDataList];
}
