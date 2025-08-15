import 'package:fahad_khan/Model/Task.dart';
import 'package:fahad_khan/views/GetCompletedTask.dart';
import 'package:fahad_khan/views/GetinCompletedTask.dart';
import 'package:fahad_khan/views/update%20task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/Task.dart';
import '../provider/user.dart';
import 'CreateTask.dart';
import 'get all priority.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetallpriorityView()),
              );
            },
            icon: Icon(Icons.category),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => getCompletedTaskview()),
              );
            },
            icon: Icon(Icons.circle),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => getinCompletedTaskview(),
                ),
              );
            },
            icon: Icon(Icons.incomplete_circle),
          ),
        ],
      ),
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
        value: TaskServices().getallTask(user.getUser().docId.toString()),
        initialData: [Welcome()],
        builder: (context, child) {
          List<Welcome> taskList = context.watch<List<Welcome>>();
          return taskList.isNotEmpty
              ? taskList[0].docId == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
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
                            taskID: taskList[i].docId.toString(),
                            isCompleted: val!,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await TaskServices()
                              .deleteTask(
                            taskList[i].docId.toString(),
                          )
                              .then((val) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
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
                          ).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
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
          )
              : Center(child: Text("No Data Found!"));
        },
      ),
    );
  }
}