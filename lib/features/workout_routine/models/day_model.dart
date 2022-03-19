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
    return DayModel(
      dayName: json["dayName"],
      dayType: json["dayType"],
      workouts: json["workouts"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dayName": dayName,
      "dayType": dayType,
      "workouts": workouts,
    };
  }
}
