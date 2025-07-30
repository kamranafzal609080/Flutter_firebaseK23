import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/Task.dart';

class TaskServices{
  ///create task
  Future createtask(Welcome model) async{
    return await FirebaseFirestore
        .instance.collection("taskCollection").add(model.toJson());
  }
  ///update task
  Future updatetask(Welcome model) async{
    return await FirebaseFirestore
        .instance.collection("taskCollection").doc(model.docId)
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
  ///Get Completed Task
  ///Get InCompleted Task
}