import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreathingBloc extends Bloc<BreathingEvent, BreathingState> {
  BreathingBloc() : super(BreathingInitial()) {
    // 이벤트 핸들러 등록
    on<StartSession>(_onStartSession);
    on<StopSession>(_onStopSession);
  }
  // 이벤트 핸들러 : 세션 시작
  void _onStartSession(StartSession event, Emitter<BreathingState> emit) async {
    for (int i = 0; i < event.session.repetitions; i++) {
      for (int j = 1; j <= event.session.breaths; j++) {
        emit(BreathingInProgress(session: event.session, breathCount: j));
        await Future.delayed(Duration(seconds: 1));
      }
      for (int k = 0; k <= event.session.retentionTime; k++) {
        emit(RetentionInProgress(session: event.session, elapsedSeconds: k));
        await Future.delayed(Duration(seconds: 1));
      }
      for (int l = 0; l <= event.session.recoveryTime; l++) {
        emit(RecoveryInProgress(session: event.session, elapsedSeconds: l));
        await Future.delayed(Duration(seconds: 1));
      }
    }
    emit(BreathingStopped());
  }

  // 이벤트 핸들러 : 세션 종료
  void _onStopSession(StopSession event, Emitter<BreathingState> emit) {
    emit(BreathingStopped());
  }
}