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
    on<SaveRoutineInLocalDBEvent>(_onSaveRoutineInLocalDBEvent);
    on<GetRoutinesFromLocalDB>(_onGetRoutinesFromLocalDB);
    on<DeleteRoutinesFromLocalDB>(_onDeleteRoutinesFromLocalDB);
    on<UpdateRoutineInLocalDBEvent>(_onUpdateRoutineInLocalDBEvent);
  }

  FutureOr<void> _onSaveRoutineInLocalDBEvent(
    SaveRoutineInLocalDBEvent event,
    Emitter<RoutineState> emit,
  ) async {
    emit(RoutineLoading());
    var routines = await routineServices.saveRoutineInLocalDB(event.routine);
    emit(RoutinesLoaded(routines));
  }

  Future<FutureOr<void>> _onGetRoutinesFromLocalDB(
      GetRoutinesFromLocalDB event, Emitter<RoutineState> emit) async {
    emit(RoutineLoading());
    var routines = await routineServices.getRoutines();
    emit(RoutinesLoaded(routines));
  }

  Future<FutureOr<void>> _onDeleteRoutinesFromLocalDB(
    DeleteRoutinesFromLocalDB event,
    Emitter<RoutineState> emit,
  ) async {
    emit(RoutineLoading());
    var routines = await routineServices.deleteRoutine(event.id);
    emit(RoutinesLoaded(routines));
  }

  Future<FutureOr<void>> _onUpdateRoutineInLocalDBEvent(
      UpdateRoutineInLocalDBEvent event, Emitter<RoutineState> emit) async {
    emit(RoutineLoading());
    var routines = await routineServices.updateRoutineInLocalDB(event.routine);
    emit(RoutinesLoaded(routines));
  }
}
