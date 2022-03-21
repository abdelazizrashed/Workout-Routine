import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';

class TodaysWorkoutWorkoutCard extends StatelessWidget {
  final WorkoutModel workout;
  final Function(WorkoutModel) onCancel;
  final Function(int, int, int) onSave;
  TodaysWorkoutWorkoutCard({
    Key? key,
    required this.workout,
    required this.onCancel,
    required this.onSave,
  }) : super(key: key);

  TextEditingController setsController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    onCancel(workout);
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
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
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: setsController,
                decoration: const InputDecoration(
                  hintText: "Sets",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: repsController,
                decoration: const InputDecoration(
                  hintText: "Reps",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: weightController,
                decoration: const InputDecoration(
                  hintText: "Weight",
                ),
              ),
            ),
            workout.imgPath.isEmpty || workout.imgPath == " "
                ? Container()
                : Center(
                    child: Image(
                      image: FileImage(
                        File(workout.imgPath),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: OutlinedButton(
                  onPressed: () {
                    onSave(
                      int.parse(setsController.text),
                      int.parse(repsController.text),
                      int.parse(weightController.text),
                    );
                    onCancel(workout);
                  },
                  child: const Text("Save"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
