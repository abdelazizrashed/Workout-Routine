import 'package:flutter/material.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';

class ReportWorkoutCard extends StatelessWidget {
  final WorkoutReportModel workout;
  const ReportWorkoutCard({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              workout.name,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Sets X Reps: ${workout.sets} X ${workout.reps}",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Weight: ${workout.weight}",
            ),
          ),
        ],
      ),
    );
  }
}
