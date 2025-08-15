import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/Task.dart';

class TaskServices {
  ///create task
  Future createtask(Welcome model) async {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("taskCollection").doc();
    return await FirebaseFirestore.instance
        .collection("taskCollection").doc(documentReference.id)
        .set(model.toJson( documentReference.id ));
  }

  ///update task
  Future updatetask(Welcome model) async {
    return await FirebaseFirestore.instance
        .collection("taskCollection")
        .doc(model.docId)
        .update({'title': model.title, 'description': model.description});
  }

  ///delete task
  Future deleteTask(String taskID) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .delete();
  }

  /// Mark task as Complete
  Future markTaskAsComplete({
    required String taskID,
    required bool isCompleted,
}) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({'isCompleted': isCompleted});
  }

  ///Get All Task
  Stream<List<Welcome>> getallTask(String userID) {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('userID', isEqualTo: userID)
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
  Stream<List<Welcome>> getInCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map(
          (taskList) => taskList.docs
          .map((taskJson) => Welcome.fromJson(taskJson.data()))
          .toList(),
    );
  }

  /// get priority task
  Stream<List<Welcome>> getPriorityTask(String priorityID) {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('priorityID', isEqualTo: priorityID)
        .snapshots()
        .map(
          (taskList) => taskList.docs
          .map((taskJson) => Welcome.fromJson(taskJson.data()))
          .toList(),
    );
  }
}
