import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:workout_routine/features/workout_routine/ui/widgets/widgets.dart';

import '../../bloc/blocs.dart';
import '../../models/models.dart';

class TodaysWorkoutPage extends StatefulWidget {
  const TodaysWorkoutPage({Key? key}) : super(key: key);

  @override
  State<TodaysWorkoutPage> createState() => _TodaysWorkoutPageState();
}

class _TodaysWorkoutPageState extends State<TodaysWorkoutPage> {
  RoutineModel selectedRoutine = RoutineModel(
      name: "Select Routine",
      sat: DayModel(),
      sun: DayModel(),
      mon: DayModel(),
      tue: DayModel(),
      wed: DayModel(),
      thu: DayModel(),
      fri: DayModel(),
      id: "empty");
  List<RoutineModel> routines = [];
  List<WorkoutModel> workouts = [];
  List<TodaysWorkoutWorkoutCard> workoutsCards = [];
  @override
  Widget build(BuildContext context) {
    if (routines.isEmpty) routines.add(selectedRoutine);
    BlocProvider.of<RoutineBloc>(context).add(const GetRoutinesFromLocalDB());

    return BlocBuilder<RoutineBloc, RoutineState>(
      builder: (context, state) {
        if (state is RoutineLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is RoutinesLoaded) {
          if (routines.length <= 1) {
            routines = [selectedRoutine, ...state.routines];
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<RoutineModel>(
                    value: selectedRoutine,
                    items:
                        routines.map<DropdownMenuItem<RoutineModel>>((routine) {
                      return DropdownMenuItem(
                        child: Text(routine.name),
                        value: routine,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRoutine = value!;
                      });
                      switch (DateFormat.EEEE().format(
                          DateTime.now().subtract(const Duration(days: 2)))) {
                        case "Saturday":
                          setState(() {
                            workouts = selectedRoutine.sat.workouts;
                          });
                          break;
                        case "Sunday":
                          setState(() {
                            workouts = selectedRoutine.sun.workouts;
                          });
                          break;
                        case "Monday":
                          setState(() {
                            workouts = selectedRoutine.mon.workouts;
                          });
                          break;
                        case "Tuesday":
                          setState(() {
                            workouts = selectedRoutine.tue.workouts;
                          });
                          break;
                        case "Wednesday":
                          setState(() {
                            workouts = selectedRoutine.wed.workouts;
                          });
                          break;
                        case "Thursday":
                          setState(() {
                            workouts = selectedRoutine.thu.workouts;
                          });
                          break;
                        case "Friday":
                          setState(() {
                            workouts = selectedRoutine.fri.workouts;
                          });
                          break;
                      }
                      setState(() {
                        workoutsCards = [];
                        for (var workout in workouts) {
                          workoutsCards.add(
                            TodaysWorkoutWorkoutCard(
                              workout: workout,
                              onCancel: (_workout) {
                                var index = workouts.indexOf(_workout);
                                print(index);
                                setState(() {
                                  workoutsCards.removeAt(index);
                                  workouts.removeAt(index);
                                });
                              },
                              onSave: (sets, reps, weight) {
                                print(sets);
                                print(reps);
                                print(weight);
                              },
                            ),
                          );
                        }
                      });
                    },
                  ),
                ),
                ...workoutsCards
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
