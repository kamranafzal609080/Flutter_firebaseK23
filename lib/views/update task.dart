import 'package:fahad_khan/Model/Task.dart';
import 'package:fahad_khan/Services/Task.dart';
import 'package:flutter/material.dart';

import 'CreateTask.dart';

class updateTaskView  extends StatefulWidget {
  final Welcome model;
  updateTaskView ({super.key, required this.model});

  @override
  State<updateTaskView> createState() => _updateTaskViewState();
}

class _updateTaskViewState extends State<updateTaskView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isloading = false;

  @override
  void initState() {
    titleController = TextEditingController(
      text: widget.model.title.toString(),

    );
    descriptionController = TextEditingController(
      text: widget.model.description.toString(),

    );
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task '),

      ),
      body: Column(
        children: [
          TextField(controller: titleController,),
          TextField(controller: descriptionController,),
          SizedBox(height: 20,),
          isloading
              ?Center(child: CircularProgressIndicator(),)
              :ElevatedButton(
            onPressed: ()async{
              if(titleController.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('title connot be empty')),
                );
                return;
              }
              if(descriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('description connot be empty')),
                );
                return;
              }
              try {
                isloading = true;
                setState(() {});
                await TaskServices()
                    .updatetask(
                  Welcome(
                    title: titleController.text,
                    description: descriptionController.text,
                    docId: widget.model.docId.toString(),
                  ),
                )
                    .then((val) {
                  isloading = false;
                  setState(() {});
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text('Message'),
                      content: Text('Task has been update successfully'),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, child: Text('Okey'),
                        ),
                      ],
                    );
                  }
                  );
                }
                );
              }
              catch(e){
                isloading = false;
                setState(() {});
                ScaffoldMessenger.of(context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },

            child: Text('update Task'),

          )

        ],
      ),
    );
  }
}
