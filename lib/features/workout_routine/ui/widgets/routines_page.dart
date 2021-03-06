import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_routine/features/workout_routine/bloc/blocs.dart';
import 'package:workout_routine/features/workout_routine/ui/widgets/routine_card.dart';

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
              return RoutineCard(routine: state.routines[index]);
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
