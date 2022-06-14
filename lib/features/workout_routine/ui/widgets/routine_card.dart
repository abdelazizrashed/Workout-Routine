import 'dart:io';
import "dart:convert" as convert;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workout_routine/features/workout_routine/bloc/routine/routine_bloc.dart';
import 'package:workout_routine/features/workout_routine/models/routine_model.dart';

class RoutineCard extends StatefulWidget {
  final RoutineModel routine;
  const RoutineCard({
    Key? key,
    required this.routine,
  }) : super(key: key);

  @override
  State<RoutineCard> createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              BlocProvider.of<RoutineBloc>(context).add(
                DeleteRoutinesFromLocalDB(
                  widget.routine.id,
                ),
              );
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.of(context)
                  .pushNamed("/modify-routine", arguments: widget.routine);
            },
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Modify',
          ),
          SlidableAction(
            onPressed: (context) async {
              widget.routine.toJson();
              Directory directory = await getApplicationDocumentsDirectory();
              int count = 0;
              var jsonFile =
                  File("${directory.path}/${widget.routine.name}.json");
              while (jsonFile.existsSync()) {
                count++;
                jsonFile = File(
                    "${directory.path}/${widget.routine.name}($count).json");
              }
              await jsonFile
                  .writeAsString(convert.jsonEncode(widget.routine.toJson()));
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Wrote json file at ${jsonFile.path}"),
                ),
              );
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.import_export,
            label: 'Export',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 2,
        ),
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              "/view-routine",
              arguments: widget.routine,
            );
          },
          title: Center(
            child: Text(
              widget.routine.name,
            ),
          ),
        ),
      ),
    );
  }
}
