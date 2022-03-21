import 'dart:io';

import 'package:flutter/material.dart';
import 'package:workout_routine/features/workout_routine/models/day_model.dart';

import '../../models/models.dart';

class ViewRoutineDaySubpage extends StatelessWidget {
  final DayModel day;
  const ViewRoutineDaySubpage({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (day.dayType == DayType.rest) {
      return const Center(
        child: Text("This day is a rest."),
      );
    } else {
      return ListView.builder(
        itemCount: day.workouts.length,
        itemBuilder: (context, index) {
          var workout = day.workouts[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                  workout.imgPath.isEmpty || workout.imgPath == " "
                      ? Container()
                      : Center(
                          child: Image(
                            image: FileImage(
                              File(workout.imgPath),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
