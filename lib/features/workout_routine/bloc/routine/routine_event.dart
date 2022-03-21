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

class UpdateRoutineInLocalDBEvent extends RoutineEvent {
  final RoutineModel routine;

  const UpdateRoutineInLocalDBEvent(this.routine);

  @override
  List<Object?> get props => [routine];
}

class GetRoutinesFromLocalDB extends RoutineEvent {
  const GetRoutinesFromLocalDB();

  @override
  List<Object?> get props => [];
}

class DeleteRoutinesFromLocalDB extends RoutineEvent {
  final String id;
  const DeleteRoutinesFromLocalDB(this.id);

  @override
  List<Object?> get props => [id];
}
