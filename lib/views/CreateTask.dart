import 'package:fahad_khan/Model/Task.dart';
import 'package:fahad_khan/Services/Task.dart';
import 'package:fahad_khan/Services/priority.dart';
import 'package:flutter/material.dart';

import '../Model/Priority.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isloading = false;
  List<PrioritiyModel> priorityList = [];
  PrioritiyModel? _selectedPriority;

  @override
  void initState() {
    // TODO: implement initState
    PriorityServices().getAllPriorities().first.then((val){
      priorityList = val;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task '),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          TextField(
            controller: descriptionController,
          ),
          SizedBox(height: 20,),
          DropdownButton(
              items: priorityList.map((e){
            return DropdownMenuItem( value : e,child: Text(e.name.toString()));
          }).toList(),
              isExpanded: true,
              value: _selectedPriority,
              hint: Text("Selected Prioity"),
              onChanged: (val){
            _selectedPriority = val;
            setState(() {

            });
              }),
          SizedBox(height: 20,),

          isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('title connot be empty',
                            style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,),
                      );
                      return;
                    }
                    if (descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'description connot be empty',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    try {
                      isloading = true;
                      setState(() {});
                      await TaskServices()
                          .createtask(
                        Welcome(
                          title: titleController.text,
                          description: descriptionController.text,
                          isCompleted: false,
                          priorityID: _selectedPriority!.docId.toString(),
                          createdAt: DateTime.now().millisecondsSinceEpoch,
                        ),
                      )
                          .then((val) {
                        isloading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Message'),
                                content:
                                    Text('Task has been created successfully'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Okey'),
                                  ),
                                ],
                              );
                            });
                      });
                    } catch (e) {
                      isloading = false;
                      setState(() {});
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text('Create Task'),
                )
        ],
      ),
    );
  }
}
