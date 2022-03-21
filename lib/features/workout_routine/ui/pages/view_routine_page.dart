import 'package:flutter/material.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';
import 'package:workout_routine/features/workout_routine/ui/pages/pages.dart';

class ViewRoutinePage extends StatelessWidget {
  final RoutineModel routine;
  const ViewRoutinePage({Key? key, required this.routine}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            routine.name,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text("S"),
              ),
              Tab(
                child: Text("S"),
              ),
              Tab(
                child: Text("M"),
              ),
              Tab(
                child: Text("T"),
              ),
              Tab(
                child: Text("W"),
              ),
              Tab(
                child: Text("T"),
              ),
              Tab(
                child: Text("F"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ViewRoutineDaySubpage(day: routine.sat),
            ViewRoutineDaySubpage(day: routine.sun),
            ViewRoutineDaySubpage(day: routine.mon),
            ViewRoutineDaySubpage(day: routine.tue),
            ViewRoutineDaySubpage(day: routine.wed),
            ViewRoutineDaySubpage(day: routine.thu),
            ViewRoutineDaySubpage(day: routine.fri),
          ],
        ),
      ),
    );
  }
}
