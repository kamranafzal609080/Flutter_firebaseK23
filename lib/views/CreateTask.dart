import 'package:fahad_khan/Model/Task.dart';
import 'package:fahad_khan/Services/Task.dart';
import 'package:flutter/material.dart';

class CreateTaskView  extends StatefulWidget {
  const CreateTaskView ({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task '),

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
                      .createtask(
                    Welcome(
                      title: titleController.text,
                      description: descriptionController.text,
                      isCompleted: false,
                      createdAt: DateTime
                          .now()
                          .millisecondsSinceEpoch,
                    ),
                  )
                      .then((val) {
                    isloading = false;
                    setState(() {});
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text('Message'),
                        content: Text('Task has been created successfully'),
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

            child: Text('Create Task'),
            
          )

        ],
      ),
    );
  }
}
