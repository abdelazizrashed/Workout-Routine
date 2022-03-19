import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';
import 'package:workout_routine/features/workout_routine/services/routine_services.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  late RoutineServices routineServices;
  RoutineBloc() : super(RoutineIdle()) {
    routineServices = RoutineServices();
    // on<RoutineEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<SaveRoutineInLocalDBEvent>(_onSaveRoutineInLocalDBEvent);
  }

  FutureOr<void> _onSaveRoutineInLocalDBEvent(
    SaveRoutineInLocalDBEvent event,
    Emitter<RoutineState> emit,
  ) async {
    emit(RoutineLoading());
    await routineServices.saveRoutineInLocalDB(event.routine);
    emit(const RoutineSetSuccess());
  }
}
