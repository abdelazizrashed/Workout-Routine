import 'package:localstore/localstore.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';

class RoutineServices {
  final db = Localstore.instance;

  Future<void> saveRoutineInLocalDB(RoutineModel routine) async {
    var json = routine.toJson();

    //Getnew id
    final id = db.collection('Routines').doc().id;
    // save the item
    await db.collection('Routines').doc(id).set(json);
  }
}
