part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final DayReportModel dayReport;
  const ReportLoaded(this.dayReport);
  @override
  List<Object> get props => [dayReport];
}
