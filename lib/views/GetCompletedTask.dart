import 'package:fahad_khan/Services/Task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/Task.dart';

class getCompletedTaskview extends StatelessWidget {
   getCompletedTaskview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get complated Task') ,
      ),
      body: StreamProvider.value(
        value: TaskServices().getCompletedTask(),
        initialData: [Welcome ()],
        builder: (context,child){
          List<Welcome> taskList = context.watch<List<Welcome>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context,i){
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[i].title.toString()),
                subtitle: Text(taskList[i].description.toString()),
              );

            },
          );
        },
      ),
    );
  }
}
