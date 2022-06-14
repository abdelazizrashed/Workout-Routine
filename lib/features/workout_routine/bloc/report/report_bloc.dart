import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_routine/features/workout_routine/services/services.dart';

import '../../models/models.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  late ReportServices _reportServices;
  ReportBloc() : super(ReportLoading()) {
    _reportServices = ReportServices();
    on<SaveWorkoutReportInLocalDBEvent>(_onSaveWorkoutReportInLocalDBEvent);
    on<GetDayReportFromLocalDB>(_onGetDayReportFromLocalDB);
  }

  Future<FutureOr<void>> _onSaveWorkoutReportInLocalDBEvent(
      SaveWorkoutReportInLocalDBEvent event, Emitter<ReportState> emit) async {
    emit(ReportLoading());
    var dayReport = await _reportServices.saveWorkoutReportInLocalDB(
        event.day, event.workoutReport);
    emit(ReportLoaded(dayReport));
  }

  Future<FutureOr<void>> _onGetDayReportFromLocalDB(
      GetDayReportFromLocalDB event, Emitter<ReportState> emit) async {
    emit(ReportLoading());
    var dayReport = await _reportServices.getDayReport(event.day);
    emit(ReportLoaded(dayReport));
  }
}
