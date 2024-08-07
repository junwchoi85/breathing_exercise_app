import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_state.dart';

class BreathingBloc extends Bloc<BreathingEvent, BreathingState> {
  List<BreathingSessionData> sessionDataList = [];

  BreathingBloc() : super(BreathingInitial()) {
    on<StartSession>(_onStartSession);
    on<StopSession>(_onStopSession);
  }

  void _onStartSession(StartSession event, Emitter<BreathingState> emit) async {
    for (int i = 0; i < event.session.repetitions; i++) {
      for (int j = 1; j <= event.session.breaths; j++) {
        emit(BreathingInProgress(session: event.session, breathCount: j));
        await Future.delayed(const Duration(seconds: 1));
      }
      for (int k = 0; k <= event.session.retentionTime; k++) {
        emit(RetentionInProgress(session: event.session, elapsedSeconds: k));
        await Future.delayed(const Duration(seconds: 1));
      }
      sessionDataList.add(BreathingSessionData(
        sessionNumber: i + 1,
        retentionTime: event.session.retentionTime,
        recoveryTime: event.session.recoveryTime,
        date: DateTime.now(),
      ));
      for (int l = 0; l <= event.session.recoveryTime; l++) {
        emit(RecoveryInProgress(session: event.session, elapsedSeconds: l));
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    emit(BreathingStopped(sessionDataList: sessionDataList));
  }

  void _onStopSession(StopSession event, Emitter<BreathingState> emit) {
    emit(BreathingStopped(sessionDataList: sessionDataList));
  }
}

class BreathingSessionData {
  final int sessionNumber;
  final int retentionTime;
  final int recoveryTime;
  final DateTime date;

  BreathingSessionData({
    required this.sessionNumber,
    required this.retentionTime,
    required this.recoveryTime,
    required this.date,
  });
}
