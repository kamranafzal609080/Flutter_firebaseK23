import 'package:fahad_khan/Services/priority.dart';
import 'package:flutter/material.dart';

import '../Model/Priority.dart';

class Createpriority extends StatefulWidget {
  const Createpriority({super.key});

  @override
  State<Createpriority> createState() => _CreatepriorityState();
}

class _CreatepriorityState extends State<Createpriority> {
  TextEditingController nameCotroller = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create priority '),
        ),
          body: Column(
        children: [
          TextField(controller: nameCotroller,),
          SizedBox(height: 20,),
          isLoading
              ?Center(child: CircularProgressIndicator(),)
              :ElevatedButton(
            onPressed: ()async{
              if(nameCotroller.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Name connot be empty')),
                );
                return;
              }
              try {
                isLoading = true;
                setState(() {});
                await PriorityServices()
                    .createPriority(
                  PrioritiyModel(
                   name: nameCotroller.text,
                    createdAt: DateTime
                        .now()
                        .millisecondsSinceEpoch,
                  ),
                )
                    .then((val) {
                  isLoading = false;
                  setState(() {});
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text('Message'),
                      content: Text('Prioritiy has been created successfully'),
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
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },

            child: Text('Create Prioritiy'),

          )

        ],
      ),
    );
  }
}
