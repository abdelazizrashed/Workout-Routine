part of 'routine_bloc.dart';

abstract class RoutineState extends Equatable {
  const RoutineState();

  @override
  List<Object> get props => [];
}

class RoutineLoading extends RoutineState {}

class RoutineIdle extends RoutineState {}

class RoutineFailure extends RoutineState {}

class RoutinesLoaded extends RoutineState {
  final List<RoutineModel> routines;
  const RoutinesLoaded(this.routines);
  @override
  List<Object> get props => [routines];
}
