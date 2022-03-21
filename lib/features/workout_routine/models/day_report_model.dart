import 'package:workout_routine/features/workout_routine/models/models.dart';

class DayReportModel {
  final DateTime date;
  final List<WorkoutReportModel> workoutReports;

  DayReportModel(this.date, this.workoutReports);
}
