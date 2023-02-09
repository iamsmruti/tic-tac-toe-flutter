// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_v2/models/user_model.dart';
import 'package:tic_tac_toe_v2/providers/auth_provider.dart';
import 'package:tic_tac_toe_v2/screens/home_screen.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    usernameController.dispose();
  }

  void storeData() async {
    if (_formKey.currentState!.validate()) {
      final ap = Provider.of<AuthProvider>(context, listen: false);
      UserModel userModel = UserModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        username: usernameController.text.trim(),
        createdAt: "",
        phoneNumber: "",
        uid: "",
      );

      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Material(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/register.png",
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    "The Final Step",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Enter your details to continue",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your name";
                      }

                      return null;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your name",
                      labelText: "Name",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your username";
                      } else if (value.length < 6) {
                        return "Username must be at least 6 characters";
                      } else if (value.length > 10) {
                        return "Username must be at most 12 characters";
                      }

                      return null;
                    },
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your username",
                      labelText: "Username",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      } else if (!value.contains("@")) {
                        return "Please enter a valid email";
                      }

                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your email",
                      labelText: "Email",
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      storeData();
                    },
                    child: const Text("Register"),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )),
    );
  }
}
