import 'package:fahad_khan/Services/user.dart';
import 'package:fahad_khan/views/profile.dart';
import 'package:fahad_khan/views/register.dart';
import 'package:fahad_khan/views/reset%20pwd.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/Auth.dart';
import '../provider/user.dart';
import 'Get all Task.dart';

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
      body: Stack(
        children: [
          // Blue Curved Header
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(120),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 40,
            child: const Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Main Login Form
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 300),

                  // Email
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Password
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Email cannot be empty."),
                          ),
                        );
                        return;
                      }
                      if (passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password cannot be empty."),
                          ),
                        );
                        return;
                      }

                      try {
                        isLoading = true;
                        setState(() {});

                        await AuthServices()
                            .loginUser(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        )
                            .then((val) async {
                          await UserServices()
                              .getUser(val.uid)
                              .then((userDate) {
                            user.setUser(userDate);
                          });

                          isLoading = false;
                          setState(() {});

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Message"),
                                content: const Text(
                                    "User has been logged in successfully"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GetAllTaskView(),
                                        ),
                                      );
                                    },
                                    child: const Text("Okay"),
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      } catch (e) {
                        isLoading = false;
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Go to SignUp
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterView(),
                        ),
                      );
                    },
                    child: const Text(
                      "Go to signUP",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                   SizedBox(height: 20),

                  // Go to Reset Password (Text link instead of button)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordView(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
