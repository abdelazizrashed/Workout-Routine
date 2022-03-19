import 'package:localstore/localstore.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';

class RoutineServices {
  final db = Localstore.instance;

  Future<List<RoutineModel>> saveRoutineInLocalDB(RoutineModel routine) async {
    var json = routine.toJson();

    //Getnew id
    final id = db.collection('Routines').doc().id;
    // save the item
    await db.collection('Routines').doc(id).set(json);
    return await getRoutines();
  }

  Future<List<RoutineModel>> getRoutines() async {
    var routinesJson = await db.collection('Routines').get();
    List<RoutineModel> routines = [];
    routinesJson?.forEach(
      (key, value) {
        var id = key.replaceAll("\\Routines\\", "");
        value["id"] = id;
        routines.add(RoutineModel.fromJson(value));
      },
    );
    routines.sort(((a, b) => a.name.compareTo(b.name)));
    return routines;
  }

  Future<List<RoutineModel>> deleteRoutine(String id) async {
    await db.collection("Routines").doc(id).delete();
    return await getRoutines();
  }
}
