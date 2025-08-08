import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahad_khan/Model/Task.dart';

import '../Model/Priority.dart';

class PriorityServices {
  ///create priority
  Future createPriority(PrioritiyModel model) async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('priortyCollection').doc();
    return await FirebaseFirestore.instance
        .collection('priortyCollection')
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  ///update priority
  Future updatePriority(PrioritiyModel model) async {
    return await FirebaseFirestore.instance
        .collection('priortyCollection')
        .doc(model.docId)
        .update({'name': model.name});
  }

  ///Delete prioity
  Future DeletePriority(PrioritiyModel model) async {
    return await FirebaseFirestore.instance
        .collection('priortyCollection')
        .doc(model.docId)
        .delete();
  }

  ///Get all priorities
  Stream<List<PrioritiyModel>> getAllPriorities() {
    return FirebaseFirestore.instance
        .collection('priortyCollection')
        .snapshots()
        .map(
          (priorityList) =>
          priorityList.docs
              .map(
                (priorityJson) => PrioritiyModel.fromJson(priorityJson.data()),
          )
              .toList(),
    );
  }
  }
