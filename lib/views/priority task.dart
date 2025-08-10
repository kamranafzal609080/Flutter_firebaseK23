import 'package:fahad_khan/Model/Task.dart';
import 'package:fahad_khan/views/update%20task.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Model/Priority.dart';
import '../Services/Task.dart';
import 'CreateTask.dart';

class PriorityTaskView extends StatelessWidget {
  final PrioritiyModel model;

  const PriorityTaskView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Priority Task")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTaskView()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: TaskServices().getPriorityTask(model.docId.toString()),
        initialData: [Welcome()],
        builder: (context, child) {
          List<Welcome> taskList = context.watch<List<Welcome>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[i].title.toString()),
                subtitle: Text(taskList[i].description.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: taskList[i].isCompleted,
                      onChanged: (val) async {
                        try {
                          await TaskServices().markTaskAsComplete(
                            taskID:taskList[i].docId.toString(),
                            isCompleted:val!,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                    ),

                    IconButton(
                      onPressed: () async {
                        try {
                          await TaskServices()
                              .deleteTask(taskList[i].docId.toString())
                              .then((val) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Task has been deleted successfully",
                                ),
                              ),
                            );
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                updateTaskView(model: taskList[i]),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}