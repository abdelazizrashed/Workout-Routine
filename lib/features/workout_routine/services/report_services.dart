import 'package:intl/intl.dart';
import 'package:localstore/localstore.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';

class ReportServices {
  final db = Localstore.instance;

  Future<DayReportModel> saveWorkoutReportInLocalDB(
      DateTime day, WorkoutReportModel workoutReport) async {
    final id = Localstore.instance
        .collection('Reports')
        .doc(ReportServices.formatDate(day))
        .collection("Workouts")
        .doc()
        .id;

    await Localstore.instance
        .collection('Reports')
        .doc(ReportServices.formatDate(day))
        .collection("Workouts")
        .doc(id)
        .set(workoutReport.toJson());
    return await getDayReport(day);
  }

  Future<DayReportModel> getDayReport(DateTime date) async {
    var dateStr = formatDate(date);
    var dayReport = await Localstore.instance
        .collection('Reports')
        .doc(dateStr)
        .collection("Workouts")
        .get();
    List<WorkoutReportModel> workouts = [];
    dayReport?.forEach((key, value) {
      var id = key.replaceAll("\\Reports\\$dateStr.collection\\Workouts\\", "");
      value["id"] = id;
      workouts.add(
        WorkoutReportModel.fromJson(value),
      );
    });
    return DayReportModel(date, workouts);
  }

  static String formatDate(DateTime date) {
    return DateFormat.yMMMEd().format(date);
  }
}
