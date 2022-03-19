part of 'routine_bloc.dart';

@immutable
abstract class RoutineEvent extends Equatable {
  const RoutineEvent();

  @override
  List<Object?> get props => [];
}

class SaveRoutineInLocalDBEvent extends RoutineEvent {
  final RoutineModel routine;

  const SaveRoutineInLocalDBEvent(this.routine);

  @override
  List<Object?> get props => [routine];
}
