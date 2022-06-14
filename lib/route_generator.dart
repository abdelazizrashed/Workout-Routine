import 'package:flutter/material.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';
import 'features/workout_routine/ui/pages/pages.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const HomePage());
      case "/add-routine":
        return MaterialPageRoute(builder: (_) => const AddRoutinePage());
      case "/view-routine":
        var routine = settings.arguments as RoutineModel;
        return MaterialPageRoute(
            builder: (_) => ViewRoutinePage(routine: routine));
      case "/modify-routine":
        var routine = settings.arguments as RoutineModel;
        return MaterialPageRoute(
            builder: (_) => ModifyRoutinePage(routine: routine));
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
