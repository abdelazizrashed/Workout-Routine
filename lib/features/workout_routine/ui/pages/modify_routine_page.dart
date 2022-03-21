import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';
import 'package:workout_routine/features/workout_routine/ui/widgets/widgets.dart';

import '../../bloc/blocs.dart';

class ModifyRoutinePage extends StatefulWidget {
  final RoutineModel routine;
  const ModifyRoutinePage({Key? key, required this.routine}) : super(key: key);

  @override
  State<ModifyRoutinePage> createState() => _ModifyRoutineState();
}

class _ModifyRoutineState extends State<ModifyRoutinePage> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  DayCardController satController = DayCardController();
  DayCardController sunController = DayCardController();
  DayCardController monController = DayCardController();
  DayCardController tueController = DayCardController();
  DayCardController wedController = DayCardController();
  DayCardController thuController = DayCardController();
  DayCardController friController = DayCardController();
  @override
  Widget build(BuildContext context) {
    nameController.text = widget.routine.name;
    var controllers = [];
    for (var _workout in widget.routine.sat.workouts) {
      controllers.add(WorkoutCardController(
        name: _workout.name,
        sets: _workout.sets,
        reps: _workout.reps,
        imgPath: _workout.imgPath,
      ));
    }
    satController = DayCardController(
        dayName: widget.routine.sat.dayName,
        dayType: widget.routine.sat.dayType,
        workoutCardControllers: controllers);
    controllers = [];
    for (var _workout in widget.routine.sun.workouts) {
      controllers.add(WorkoutCardController(
        name: _workout.name,
        sets: _workout.sets,
        reps: _workout.reps,
        imgPath: _workout.imgPath,
      ));
    }
    sunController = DayCardController(
        dayName: widget.routine.sun.dayName,
        dayType: widget.routine.sun.dayType,
        workoutCardControllers: controllers);
    controllers = [];
    for (var _workout in widget.routine.mon.workouts) {
      controllers.add(WorkoutCardController(
        name: _workout.name,
        sets: _workout.sets,
        reps: _workout.reps,
        imgPath: _workout.imgPath,
      ));
    }
    monController = DayCardController(
        dayName: widget.routine.mon.dayName,
        dayType: widget.routine.mon.dayType,
        workoutCardControllers: controllers);
    controllers = [];
    for (var _workout in widget.routine.tue.workouts) {
      controllers.add(WorkoutCardController(
        name: _workout.name,
        sets: _workout.sets,
        reps: _workout.reps,
        imgPath: _workout.imgPath,
      ));
    }
    tueController = DayCardController(
        dayName: widget.routine.tue.dayName,
        dayType: widget.routine.tue.dayType,
        workoutCardControllers: controllers);
    controllers = [];
    for (var _workout in widget.routine.wed.workouts) {
      controllers.add(WorkoutCardController(
        name: _workout.name,
        sets: _workout.sets,
        reps: _workout.reps,
        imgPath: _workout.imgPath,
      ));
    }
    wedController = DayCardController(
        dayName: widget.routine.wed.dayName,
        dayType: widget.routine.wed.dayType,
        workoutCardControllers: controllers);
    controllers = [];
    for (var _workout in widget.routine.thu.workouts) {
      controllers.add(WorkoutCardController(
        name: _workout.name,
        sets: _workout.sets,
        reps: _workout.reps,
        imgPath: _workout.imgPath,
      ));
    }
    thuController = DayCardController(
        dayName: widget.routine.thu.dayName,
        dayType: widget.routine.thu.dayType,
        workoutCardControllers: controllers);
    controllers = [];
    for (var _workout in widget.routine.fri.workouts) {
      controllers.add(WorkoutCardController(
        name: _workout.name,
        sets: _workout.sets,
        reps: _workout.reps,
        imgPath: _workout.imgPath,
      ));
    }
    friController = DayCardController(
        dayName: widget.routine.fri.dayName,
        dayType: widget.routine.fri.dayType,
        workoutCardControllers: controllers);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        elevation: 0,
        title: Text("Modify ${widget.routine.name}"),
      ),
      body: BlocConsumer<RoutineBloc, RoutineState>(
        listener: ((context, state) {
          if (state is RoutinesLoaded) {
            Navigator.of(context).pop();
          }
        }),
        builder: (context, state) {
          if (state is RoutineLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Workout routine name",
                    ),
                  ),
                ),
                ModifyDayCard(
                  dayCardController: satController,
                  day: "Saterday",
                  dayModel: widget.routine.sat,
                ),
                ModifyDayCard(
                  dayCardController: sunController,
                  day: "Sunday",
                  dayModel: widget.routine.sun,
                ),
                ModifyDayCard(
                  dayCardController: monController,
                  day: "Monday",
                  dayModel: widget.routine.mon,
                ),
                ModifyDayCard(
                  dayCardController: tueController,
                  day: "Tuesday",
                  dayModel: widget.routine.tue,
                ),
                ModifyDayCard(
                  dayCardController: wedController,
                  day: "Wednesday",
                  dayModel: widget.routine.wed,
                ),
                ModifyDayCard(
                  dayCardController: thuController,
                  day: "Thursday",
                  dayModel: widget.routine.thu,
                ),
                ModifyDayCard(
                  dayCardController: friController,
                  day: "Friday",
                  dayModel: widget.routine.fri,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: OutlinedButton(
                    onPressed: () {
                      // var routine = RoutineModel(
                      var newRoutine = widget.routine.copyWith(
                        name_: nameController.text,
                        sat_: satController.toDayModel(),
                        sun_: sunController.toDayModel(),
                        mon_: monController.toDayModel(),
                        tue_: tueController.toDayModel(),
                        wed_: wedController.toDayModel(),
                        thu_: thuController.toDayModel(),
                        fri_: friController.toDayModel(),
                      );
                      BlocProvider.of<RoutineBloc>(context).add(
                        UpdateRoutineInLocalDBEvent(newRoutine),
                      );
                    },
                    child: const Text("Modify"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
