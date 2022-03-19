import 'package:flutter/material.dart';
import 'features/workout_routine/ui/pages/pages.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //get the argument that have been passed with the route

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const HomePage());
      case "/add-routine":
        return MaterialPageRoute(builder: (_) => const AddRoutinePage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
    // throw Exception("No Route");
  }
}
