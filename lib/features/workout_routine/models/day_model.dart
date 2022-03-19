import 'package:workout_routine/features/workout_routine/models/models.dart';

class DayModel {
  final DayType dayType;
  final List<WorkoutModel> workouts;
  final String dayName;

  DayModel({
    this.dayType = DayType.rest,
    this.workouts = const [],
    this.dayName = "Rest",
  });

  static DayModel fromJson(Map<String, dynamic> json) {
    List<WorkoutModel> workouts = [];
    for (var j in json["workouts"]) {
      workouts.add(WorkoutModel.fromJson(j));
    }
    return DayModel(
      dayName: json["dayName"],
      dayType: json["isRest"] ? DayType.rest : DayType.workout,
      workouts: workouts,
    );
  }

  Map<String, dynamic> toJson() {
    var workoutsJson = [];
    for (var workout in workouts) {
      workoutsJson.add(workout.toJson());
    }
    return {
      "dayName": dayName,
      "isRest": dayType == DayType.rest,
      "workouts": workoutsJson,
    };
  }
}
