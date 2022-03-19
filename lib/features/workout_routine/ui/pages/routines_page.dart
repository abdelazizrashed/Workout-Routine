import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workout_routine/features/workout_routine/bloc/blocs.dart';

class RoutinesPage extends StatelessWidget {
  const RoutinesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RoutineBloc>(context).add(const GetRoutinesFromLocalDB());
    return BlocBuilder<RoutineBloc, RoutineState>(
      builder: (context, state) {
        if (state is RoutineLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is RoutinesLoaded) {
          return ListView.builder(
            itemCount: state.routines.length,
            itemBuilder: (context, index) {
              return Slidable(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 2,
                  ),
                  child: ListTile(
                    onTap: () {
                      //TODO: LOAD MODIFY ROUTINE PAGE
                    },
                    title: Center(
                      child: Text(
                        state.routines[index].name,
                      ),
                    ),
                  ),
                ),
                endActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),

                  // A pane can dismiss the Slidable.
                  // dismissible: DismissiblePane(onDismissed: () {}),

                  // All actions are defined in the children parameter.
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      onPressed: (context) {
                        BlocProvider.of<RoutineBloc>(context).add(
                          DeleteRoutinesFromLocalDB(
                            state.routines[index].id,
                          ),
                        );
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Modify',
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Center(
          child: Text(
            "No Routines found",
          ),
        );
      },
    );
  }
}
