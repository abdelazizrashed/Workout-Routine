import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class TodaysWorkoutCustomeWorkoutCard extends StatelessWidget {
  final Function(TodaysWorkoutCustomeWorkoutCard) onCancel;
  final Function(String, int, int, int, TodaysWorkoutCustomeWorkoutCard) onSave;
  TodaysWorkoutCustomeWorkoutCard({
    Key? key,
    required this.onCancel,
    required this.onSave,
  }) : super(key: key);

  TextEditingController nameController = TextEditingController();
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
                    onCancel(this);
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
                "Custom workout",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Workout name",
                ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: OutlinedButton(
                  onPressed: () {
                    onSave(
                      nameController.text,
                      int.parse(setsController.text),
                      int.parse(repsController.text),
                      int.parse(weightController.text),
                      this,
                    );
                    onCancel(this);
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
