import 'package:workout_routine/features/workout_routine/models/models.dart';

class WorkoutCardController {
  late String name;
  late int sets;
  late int reps;
  late String imgPath;

  WorkoutModel toWorkoutModel() {
    return WorkoutModel(sets, reps, name, imgPath);
  }
}
