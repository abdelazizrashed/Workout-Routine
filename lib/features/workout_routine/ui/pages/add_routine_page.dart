import 'package:flutter/material.dart';
import 'package:workout_routine/features/workout_routine/models/day_card_controller.dart';
import 'package:workout_routine/features/workout_routine/ui/widgets/widgets.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
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
                  var temp = satController.toDayModel();
                  print(temp.toJson());
                },
                child: Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
