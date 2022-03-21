import 'package:workout_routine/features/workout_routine/models/models.dart';

class WorkoutCardController {
  late String name = "";
  late int sets;
  late int reps;
  late String imgPath = "";

  WorkoutCardController({
    this.name = "",
    this.sets = 0,
    this.reps = 0,
    this.imgPath = "",
  });

  WorkoutModel toWorkoutModel() {
    return WorkoutModel(sets, reps, name, imgPath);
  }
}
