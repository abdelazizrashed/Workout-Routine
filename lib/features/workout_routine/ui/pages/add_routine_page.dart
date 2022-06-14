import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';
import 'package:workout_routine/features/workout_routine/ui/widgets/widgets.dart';

import '../../bloc/blocs.dart';

class AddRoutinePage extends StatefulWidget {
  const AddRoutinePage({Key? key}) : super(key: key);

  @override
  State<AddRoutinePage> createState() => _AddRoutinePageState();
}

class _AddRoutinePageState extends State<AddRoutinePage>
    with SingleTickerProviderStateMixin {
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
        title: const Text("Add Workout Routine"),
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
                DayCard(dayCardController: satController, day: "Saterday"),
                DayCard(dayCardController: sunController, day: "Sunday"),
                DayCard(dayCardController: monController, day: "Monday"),
                DayCard(dayCardController: tueController, day: "Tuesday"),
                DayCard(dayCardController: wedController, day: "Wednesday"),
                DayCard(dayCardController: thuController, day: "Thursday"),
                DayCard(dayCardController: friController, day: "Friday"),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: OutlinedButton(
                    onPressed: () {
                      var routine = RoutineModel(
                        name: nameController.text,
                        sat: satController.toDayModel(),
                        sun: sunController.toDayModel(),
                        mon: monController.toDayModel(),
                        tue: tueController.toDayModel(),
                        wed: wedController.toDayModel(),
                        thu: thuController.toDayModel(),
                        fri: friController.toDayModel(),
                      );
                      BlocProvider.of<RoutineBloc>(context).add(
                        SaveRoutineInLocalDBEvent(routine),
                      );
                    },
                    child: const Text("Save"),
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
