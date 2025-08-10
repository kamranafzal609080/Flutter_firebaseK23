import 'package:fahad_khan/Services/priority.dart';
import 'package:fahad_khan/views/priority%20task.dart';
import 'package:fahad_khan/views/update%20priotiy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/Priority.dart';
import 'Create priority.dart';

class GetallpriorityView extends StatelessWidget {
   GetallpriorityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get all Priority'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Createpriority()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: PriorityServices().getAllPriorities(),
        initialData: [PrioritiyModel()],
        builder: (context, child) {
          List<PrioritiyModel> priorityList =
              context.watch<List<PrioritiyModel>>();
          return ListView.builder(
              itemCount: priorityList.length,
              itemBuilder: (context, i) {
                return ListTile(
                    leading: Icon(Icons.category),
                    title: Text(priorityList[i].name.toString()),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                        onPressed: () async {
                          try {
                            await PriorityServices()
                                .DeletePriority(priorityList[i])
                                .then((val) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  'Priority has been deleted successfully',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                              ));
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  updatepriority(model: priorityList[i]),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PriorityTaskView(model: priorityList[i]),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_forward, color: Colors.blue),
                      ),
                    ]
                    ),
                );
              }
              );
        },
      ),
    );
  }
}
