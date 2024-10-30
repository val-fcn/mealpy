import '../models/planning.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlanningData {
  Future<void> createPlanning(Planning planning) async {
    await FirebaseFirestore.instance
        .collection('plannings')
        .doc(planning.id)
        .set(planning.toJson());
  }

  Future<void> deletePlanning(String id) async {
    await FirebaseFirestore.instance.collection('plannings').doc(id).delete();
  }

  Future<void> updatePlanning(Planning planning) async {
    await FirebaseFirestore.instance
        .collection('plannings')
        .doc(planning.id)
        .update(planning.toJson());
  }

  Future<List<Planning>> getPlannings() async {
    return await FirebaseFirestore.instance.collection('plannings').get().then(
        (value) =>
            value.docs.map((doc) => Planning.fromJson(doc.data())).toList());
  }
}
