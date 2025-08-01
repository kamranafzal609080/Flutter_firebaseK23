import 'package:fahad_khan/Services/Task.dart';
import 'package:fahad_khan/views/GetinCompletedTask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/Task.dart';
import 'CreateTask.dart';
import 'GetCompletedTask.dart';

class Getalltaskview extends StatelessWidget {
  const Getalltaskview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Get All Task') ,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>getCompletedTaskview()));

          },

              icon: Icon(Icons.circle),
          ),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>getinCompletedTaskview()));
          },

            icon: Icon(Icons.circle),
          ),

        ],
      ),
      floatingActionButton:
      FloatingActionButton(onPressed: (){
        Navigator.push(context,
        MaterialPageRoute(builder: (context)=>CreateTaskView())
        );
      },
      child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
          value: TaskServices().getallTask(),
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
