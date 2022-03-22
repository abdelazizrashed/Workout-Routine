import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';

class ModifyRoutineWorkoutCard extends StatefulWidget {
  final WorkoutCardController workoutCardController;
  final Function(WorkoutCardController) deleteCardCallback;
  final WorkoutModel workout;
  const ModifyRoutineWorkoutCard({
    Key? key,
    required this.workoutCardController,
    required this.deleteCardCallback,
    required this.workout,
  }) : super(key: key);

  @override
  State<ModifyRoutineWorkoutCard> createState() =>
      _ModifyRoutineWorkoutCardState();
}

class _ModifyRoutineWorkoutCardState extends State<ModifyRoutineWorkoutCard> {
  TextEditingController nameController = TextEditingController();

  TextEditingController setsController = TextEditingController();

  TextEditingController repsController = TextEditingController();

  PlatformFile? image;
  @override
  void initState() {
    nameController.text = widget.workout.name;
    setsController.text = widget.workout.sets.toString();
    repsController.text = widget.workout.reps.toString();
    widget.workoutCardController.name = widget.workout.name;
    widget.workoutCardController.sets = widget.workout.sets;
    widget.workoutCardController.reps = widget.workout.reps;
    widget.workoutCardController.imgPath = widget.workout.imgPath;
    image = PlatformFile(
        name: widget.workout.name, size: 0, path: widget.workout.imgPath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              Icons.cancel_outlined,
              color: Colors.grey.shade400,
            ),
            onPressed: () {
              widget.deleteCardCallback(widget.workoutCardController);
            },
          ),
          TextField(
            controller: nameController,
            onChanged: (value) {
              widget.workoutCardController.name = value;
            },
            decoration:
                const InputDecoration(hintText: "Name i.e. Bench press"),
          ),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered

            onChanged: (value) {
              widget.workoutCardController.sets = int.parse(value);
            },
            controller: setsController,
            decoration: const InputDecoration(
              hintText: "Sets",
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered

            onChanged: (value) {
              widget.workoutCardController.reps = int.parse(value);
            },
            controller: repsController,
            decoration: const InputDecoration(
              hintText: "Reps",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image == null
                  ? IconButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'png', 'jpeg', "svg"],
                        );
                        if (result != null) {
                          // print(result.files.first.);
                          setState(() {
                            image = result.files.first;
                            widget.workoutCardController.imgPath =
                                image?.path ?? "";
                          });
                        }
                      },
                      icon: const Icon(Icons.image),
                    )
                  : GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'png', 'jpeg', "svg"],
                        );
                        if (result != null) {
                          // print(result.files.first.);
                          setState(() {
                            image = result.files.first;
                            widget.workoutCardController.imgPath =
                                image?.path ?? "";
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            if (image?.path != null) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Image(
                                  image: FileImage(File(image?.path ?? "")),
                                ),
                              );
                            } else {
                              return IconButton(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'jpg',
                                      'png',
                                      'jpeg',
                                      "svg"
                                    ],
                                  );
                                  if (result != null) {
                                    // print(result.files.first.);
                                    setState(() {
                                      image = result.files.first;
                                      widget.workoutCardController.imgPath =
                                          image?.path ?? "";
                                    });
                                  }
                                },
                                icon: const Icon(Icons.image),
                              );
                            }
                          },
                        ),
                      ),
                    ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Divider(
              height: 40,
              thickness: 3,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
