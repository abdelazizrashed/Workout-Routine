class WorkoutModel {
  final int sets;
  final int reps;
  final String name;
  final String imgPath;

  WorkoutModel(this.sets, this.reps, this.name, this.imgPath);

  static WorkoutModel fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      json["sets"],
      json["reps"],
      json["name"],
      json["imgPath"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sets": sets,
      "reps": reps,
      "name": name,
      "imgPath": imgPath,
    };
  }
}
