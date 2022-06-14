part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class SaveWorkoutReportInLocalDBEvent extends ReportEvent {
  final DateTime day;
  final WorkoutReportModel workoutReport;

  const SaveWorkoutReportInLocalDBEvent(this.day, this.workoutReport);

  @override
  List<Object> get props => [day, workoutReport];
}

class GetDayReportFromLocalDB extends ReportEvent {
  final DateTime day;
  const GetDayReportFromLocalDB(this.day);

  @override
  List<Object> get props => [day];
}
