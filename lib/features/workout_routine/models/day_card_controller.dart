import 'package:workout_routine/features/workout_routine/models/models.dart';

class DayCardController {
  late DayType dayType;
  late List<WorkoutCardController> workoutCardControllers;
  late String dayName;

  DayCardController({
    this.dayType = DayType.rest,
    workoutCardControllers = const [],
    dayName = "Rest",
  }) {
    workoutCardControllers = [];
  }

  DayModel toDayModel() {
    List<WorkoutModel> workouts = [];
    for (var controller in workoutCardControllers) {
      workouts.add(controller.toWorkoutModel());
    }
    return DayModel(
      dayName: DayType.rest == dayType ? "Rest" : dayName,
      dayType: dayType,
      workouts: workouts,
    );
  }
}
