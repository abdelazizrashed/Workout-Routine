import 'package:workout_routine/features/workout_routine/models/models.dart';

class DayCardController {
  late DayType dayType;
  late List<WorkoutCardController> workoutCardControllers;
  late String dayName;

  DayModel toDayModel() {
    List<WorkoutModel> workouts = [];
    for (var controller in workoutCardControllers) {
      workouts.add(controller.toWorkoutModel());
    }
    return DayModel(dayName: dayName, dayType: dayType, workouts: workouts);
  }
}
