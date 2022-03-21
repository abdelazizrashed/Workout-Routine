import 'package:workout_routine/features/workout_routine/models/models.dart';

class RoutineModel {
  final String name;
  final String id;
  final DayModel sat;
  final DayModel sun;
  final DayModel mon;
  final DayModel tue;
  final DayModel wed;
  final DayModel thu;
  final DayModel fri;

  RoutineModel({
    required this.name,
    required this.sat,
    required this.sun,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    this.id = "",
  });

  static RoutineModel fromJson(Map<String, dynamic> json) {
    return RoutineModel(
      name: json["name"],
      sat: DayModel.fromJson(json["sat"]),
      sun: DayModel.fromJson(json["sun"]),
      mon: DayModel.fromJson(json["mon"]),
      tue: DayModel.fromJson(json["tue"]),
      wed: DayModel.fromJson(json["wed"]),
      thu: DayModel.fromJson(json["thu"]),
      fri: DayModel.fromJson(json["fri"]),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "sat": sat.toJson(),
      "sun": sun.toJson(),
      "mon": mon.toJson(),
      "tue": tue.toJson(),
      "wed": wed.toJson(),
      "thu": thu.toJson(),
      "fri": fri.toJson(),
    };
  }

  RoutineModel copyWith({
    String? id_,
    String? name_,
    DayModel? sat_,
    DayModel? sun_,
    DayModel? mon_,
    DayModel? tue_,
    DayModel? wed_,
    DayModel? thu_,
    DayModel? fri_,
  }) {
    return RoutineModel(
      id: id_ ?? id,
      name: name_ ?? name,
      sat: sat_ ?? sat,
      sun: sun_ ?? sun,
      mon: mon_ ?? mon,
      tue: tue_ ?? tue,
      wed: wed_ ?? wed,
      thu: thu_ ?? thu,
      fri: fri_ ?? fri,
    );
  }
}
