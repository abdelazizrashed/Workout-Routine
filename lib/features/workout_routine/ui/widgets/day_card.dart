import 'package:flutter/material.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';
import 'package:workout_routine/features/workout_routine/ui/widgets/widgets.dart';

class DayCard extends StatefulWidget {
  late DayCardController dayCardController;
  final String day;
  DayCard({
    Key? key,
    required this.dayCardController,
    required this.day,
  }) : super(key: key);

  @override
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  bool isRest = true;
  TextEditingController dayNameController = TextEditingController();
  int noOfWorkouts = 0;

  // List<WorkoutCardController> workoutCardControllers = [];
  // var cs = widget.dayCardController.workoutCardControllers
  List<WorkoutCard> workoutCards = [];
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.day,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          SwitchListTile.adaptive(
            title: const Text("Rest...?"),
            value: isRest,
            onChanged: (newValue) {
              setState(() {
                isRest = newValue;
                if (isRest) {
                  widget.dayCardController = DayCardController();
                  widget.dayCardController.dayType = DayType.rest;
                  widget.dayCardController.dayName = "Rest";
                } else {
                  widget.dayCardController.dayType = DayType.workout;
                  widget.dayCardController.dayName = dayNameController.text;

                  // widget.dayCardController.workoutCardControllers =
                  //     workoutCardControllers;
                }
              });
            },
          ),
          isRest
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        onChanged: (value) {
                          widget.dayCardController.dayName = value;
                        },
                        controller: dayNameController,
                        decoration: const InputDecoration(
                          hintText: "Day's focus i.e. Chest",
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Divider(
                        height: 40,
                        thickness: 3,
                        color: Colors.grey,
                      ),
                    ),
                    ...workoutCards,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          var controller = WorkoutCardController();
                          setState(() {
                            workoutCards.add(
                              WorkoutCard(
                                workoutCardController: controller,
                                deleteCardCallback: (workoutController) {
                                  setState(() {
                                    var index = widget.dayCardController.workoutCardControllers
                                        .indexOf(workoutController);
                                    widget.dayCardController.workoutCardControllers.removeAt(index);
                                    workoutCards.removeAt(index);
                                  });
                                },
                              ),
                            );
                            widget.dayCardController.workoutCardControllers.add(controller);
                            widget.dayCardController.workoutCardControllers =
                                widget.dayCardController.workoutCardControllers;
                          });
                        },
                        child: const Text(
                          "Add workout",
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}