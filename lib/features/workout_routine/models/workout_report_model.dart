class WorkoutReportModel {
  final String name;
  final int sets;
  final int reps;
  final int weight;
  final String? id;

  WorkoutReportModel({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "sets": sets,
      "reps": reps,
      "weight": weight,
    };
  }

  static WorkoutReportModel fromJson(Map<String, dynamic> json) {
    return WorkoutReportModel(
      name: json["name"],
      sets: json["sets"],
      reps: json["reps"],
      weight: json["weight"],
      id: json["id"],
    );
  }
}
