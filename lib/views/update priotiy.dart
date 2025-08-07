import 'package:fahad_khan/Model/Task.dart';
import 'package:fahad_khan/Services/Task.dart';
import 'package:fahad_khan/Services/priority.dart';
import 'package:flutter/material.dart';

import '../Model/Priority.dart';

class  updatepriority extends StatefulWidget {
  final PrioritiyModel model;
  updatepriority ({super.key, required this.model});

  @override
  State<updatepriority> createState() => _updatepriorityState();
}

class _updatepriorityState extends State<updatepriority> {
  TextEditingController nameController = TextEditingController();

  bool isloading = false;

  @override
  void initState() {
    nameController = TextEditingController(
      text: widget.model.name.toString(),

    );

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Priority '),

      ),
      body: Column(
        children: [
          TextField(controller: nameController,),

          SizedBox(height: 20,),
          isloading
              ?Center(child: CircularProgressIndicator(),)
              :ElevatedButton(
            onPressed: ()async{
              if(nameController.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('title connot be empty')),
                );
                return;

              }
              try {
                isloading = true;
                setState(() {});
                await PriorityServices()
                    .updatePriority(
                  PrioritiyModel(
                    docId: widget.model.docId.toString(),
                    name: nameController.text,
                  ),
                )
                    .then((val) {
                  isloading = false;
                  setState(() {});
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text('Message'),
                      content: Text('Priority has been update successfully'),
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

            child: Text('update Priority'),

          )

        ],
      ),
    );
  }
}
