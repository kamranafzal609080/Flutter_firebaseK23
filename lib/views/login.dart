import 'package:fahad_khan/views/register.dart';
import 'package:fahad_khan/views/reset%20pwd.dart';
import 'package:flutter/material.dart';
import '../Services/Auth.dart'; // apna service file ka path

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
                  ).then((val) {
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
                              onPressed: () {}, // close dialog
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
