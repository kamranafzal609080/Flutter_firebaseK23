import 'package:fahad_khan/Services/user.dart';
import 'package:fahad_khan/views/profile.dart';
import 'package:fahad_khan/views/register.dart';
import 'package:fahad_khan/views/reset%20pwd.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/Auth.dart';
import '../provider/user.dart'; // apna service file ka path

class LiginView extends StatefulWidget {
  const LiginView({super.key});

  @override
  State<LiginView> createState() => _LiginViewState();
}

class _LiginViewState extends State<LiginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text('Login'),
        
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email
            TextField(
              controller: emailController,
              decoration:  InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
            ),
             SizedBox(height: 12),

            // Password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration:  InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
            ),
             SizedBox(height: 20),

            // Login Button
            isLoading
                ?  CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                if (emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                        content: Text("Email cannot be empty.")),
                  );
                  return;
                }
                if (passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                        content: Text("Password cannot be empty.")),
                  );
                  return;
                }

                try {
                  isLoading = true;
                  setState(() {
                  });

                  await AuthServices().loginUser(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ).then((val) async {
                    await UserServices().getUser(val.uid).then((userDate){
                      user.setUser(userDate);
                    });
                    isLoading = false;
                    setState(() {});

                    // Success Dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Message"),
                          content: Text(
                              "User has been logged in successfully"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>profileDome()));
                              }, // close dialog
                              child: Text("Okay"),
                            ),
                          ],
                        );
                      },
                    );
                  });
                } catch (e) {
                  isLoading = false;
                  setState(() {
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },
              child:  Text('Login'),
            ),
             SizedBox(height: 20),

            // Go to SignUp
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterView(), // Replace with SignUpView()
                  ),
                );
              },
              child:  Text("Go to SignUp"),
            ),
             SizedBox(height: 20),

            // Go to Reset Password
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetPasswordView(), // Replace with ResetPasswordView()
                  ),
                );
              },
              child:  Text("Go to Reset Password"),
            ),
          ],
        ),
      ),
    );
  }
}
