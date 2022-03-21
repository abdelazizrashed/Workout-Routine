import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_routine/features/workout_routine/services/services.dart';
import 'package:workout_routine/features/workout_routine/ui/widgets/widgets.dart';

import '../../bloc/blocs.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReportBloc>(context)
        .add(GetDayReportFromLocalDB(selectedDay));
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        if (state is ReportLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ReportLoaded) {
          if (state.dayReport.workoutReports.isEmpty) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () async {
                      var pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDay,
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null && pickedDate != selectedDay) {
                        setState(() {
                          selectedDay = pickedDate;
                          BlocProvider.of<ReportBloc>(context)
                              .add(GetDayReportFromLocalDB(selectedDay));
                        });
                      }
                    },
                    child: Text(ReportServices.formatDate(selectedDay)),
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text("You didn't do any workouts this day."),
                  ),
                ),
              ],
            );
          }
          List<Widget> workoutCards = [];
          for (var workout in state.dayReport.workoutReports) {
            workoutCards.add(ReportWorkoutCard(workout: workout));
          }
          return ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Center(
                child: OutlinedButton(
                  onPressed: () async {
                    var pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDay,
                      firstDate: DateTime(1970),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null && pickedDate != selectedDay) {
                      setState(() {
                        selectedDay = pickedDate;
                        BlocProvider.of<ReportBloc>(context)
                            .add(GetDayReportFromLocalDB(selectedDay));
                      });
                    }
                  },
                  child: Text(ReportServices.formatDate(selectedDay)),
                ),
              ),
              ...workoutCards,
            ],
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () async {
                  var pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDay,
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null && pickedDate != selectedDay) {
                    setState(() {
                      selectedDay = pickedDate;
                      BlocProvider.of<ReportBloc>(context)
                          .add(GetDayReportFromLocalDB(selectedDay));
                    });
                  }
                },
                child: Text(ReportServices.formatDate(selectedDay)),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text("You didn't do any workouts this day."),
              ),
            ),
          ],
        );
      },
    );
  }
}
