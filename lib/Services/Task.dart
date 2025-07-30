import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/Task.dart';

class TaskServices {
  ///create task
  Future createtask(Welcome model) async {
    return await FirebaseFirestore.instance
        .collection("taskCollection")
        .add(model.toJson());
  }

  ///update task
  Future updatetask(Welcome model) async {
    return await FirebaseFirestore.instance
        .collection("taskCollection")
        .doc(model.docId)
        .update({'title': model.title, 'description': model.description});
  }

  ///delete task
  Future deleteTask(Welcome model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .delete();
  }

  /// Mark task as Complete
  Future markTaskAsComplete(Welcome model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({'isComplete': true});
  }

  ///Get All Task
  Stream<List<Welcome>> getallTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskJson) => Welcome.fromJson(taskJson.data()))
            .toList());
  }

  ///Get Completed Task
  Stream<List<Welcome>> getCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted',isEqualTo: true)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson) => Welcome.fromJson(taskJson.data()))
        .toList());
  }
  ///Get InCompleted Task
  Stream<List<Welcome>> getInCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted',isEqualTo: false)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson) => Welcome.fromJson(taskJson.data()))
        .toList());
  }
}
