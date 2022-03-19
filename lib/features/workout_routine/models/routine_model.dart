import 'package:workout_routine/features/workout_routine/models/models.dart';

class RoutineModel {
  final String name;
  final DayModel sat;
  final DayModel sun;
  final DayModel mon;
  final DayModel tue;
  final DayModel wed;
  final DayModel thu;
  final DayModel fri;

  RoutineModel(
    this.name,
    this.sat,
    this.sun,
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
  );

  static RoutineModel fromJson(Map<String, dynamic> json) {
    return RoutineModel(
      json["name"],
      json["sat"],
      json["sun"],
      json["mon"],
      json["tue"],
      json["wed"],
      json["thu"],
      json["fri"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "sat": sat,
      "sun": sun,
      "mon": mon,
      "tue": tue,
      "wed": wed,
      "thu": thu,
      "fri": fri,
    };
  }
}
