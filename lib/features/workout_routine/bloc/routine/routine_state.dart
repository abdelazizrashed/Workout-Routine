part of 'routine_bloc.dart';

@immutable
abstract class RoutineState extends Equatable {
  const RoutineState();

  @override
  List<Object> get props => [];
}

class RoutineLoading extends RoutineState {}

class RoutineIdle extends RoutineState {}

class RoutineFailure extends RoutineState {}

class RoutineSetSuccess extends RoutineState {
  const RoutineSetSuccess();
  @override
  List<Object> get props => [];
}

class RoutineGetSuccess extends RoutineState {
  final List<RoutineModel> routines;
  const RoutineGetSuccess(this.routines);
  @override
  List<Object> get props => [routines];
}
