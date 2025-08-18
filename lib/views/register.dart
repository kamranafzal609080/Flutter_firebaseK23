import 'package:fahad_khan/Services/user.dart';
import 'package:flutter/material.dart';
import '../Model/user.dart';
import '../Services/Auth.dart';
import 'login.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"),
      backgroundColor: Colors.blue,),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40,),
              TextField(controller: nameController,
          decoration:  InputDecoration(
              border: OutlineInputBorder(),
          labelText: "Name",
              ),
              ),
              TextField(controller: phoneController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Phone",),
              ),
              TextField(controller: addressController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Address",),
              ),
              TextField(controller: emailController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",),
              ),
              TextField(controller: pwdController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "password",),
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: () async {
                  if (emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Email cannot be empty.")),
                    );
                    return;
                  }
                  if (pwdController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password cannot be empty.")),
                    );
                    return;
                  }
                  try {
                    isLoading = true;
                    setState(() {});
                    await AuthServices()
                        .registerUser(
                      email: emailController.text,
                      password: pwdController.text,
                    )
                        .then((val) async{
                          await UserServices().createUser(
                            UserModel(
                              docId: val.uid.toString(),
                              name: nameController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                              email: emailController.text,
                              createdAt: DateTime.now().millisecondsSinceEpoch,
                            ),
                          );
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Message"),
                            content: Text(
                              "User has been registered successfully",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LiginView(),
                                    ),
                                  );
                                },
                                child: Text("Okay"),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  } catch (e) {
                    isLoading = false;
                    setState(() {});
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text("Register"),
              ),
              SizedBox(height: 20),
        
            ],
          ),
        ),
      ),
    );
  }
}