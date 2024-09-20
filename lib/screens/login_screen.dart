
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/navigation.dart';
import 'package:news_app/screens/register_screen.dart';
import 'package:news_app/screens/widgets/custome_button.dart';

import '../constants.dart';
import '../helper/snack_bar.dart';
import 'widgets/custom_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Spacer(
                flex: 3,
              ),
              const Text(
                "Scohlar Chat",
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              const Spacer(
                flex: 2,
              ),
              const Row(
                children: [
                  Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomeTextFormField(
                  validator: (data) {
                    if (data!.isEmpty) {
                      return 'email is required';
                    } else if (data.contains('@') == false) {
                      return 'email is not valid';
                    }
                  },
                  onChange: (value) {
                    email = value;
                  },
                  hintText: 'Email'),
              const SizedBox(
                height: 10,
              ),
              CustomeTextFormField(
                  validator: (data) {
                    if (data!.isEmpty) {
                      return 'password is required';
                    } else if (data.length < 7) {
                      return 'password is too short';
                    }
                  },
                  onChange: (value) {
                    password = value;
                  },
                  hintText: 'Password'),
              const SizedBox(
                height: 20,
              ),
              CustomeButton(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    try {
                      await signInUser();
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const Navigation(),));
                    } on FirebaseAuthException catch (e) {
                      print(e);

                      if (e.code == "wrong-password") {
                        snackBarMessage(context, "your password is wrong");
                      } else if (e.code == "user-not-found") {
                        snackBarMessage(context, "user-not-found");
                      }
                    } catch (e) {
                      print(e);

                      snackBarMessage(context, "there was an error");
                    }
                    isLoading = false;
                    setState(() {});
                  }
                },
                text: 'LOGIN',
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "don\'t have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterScreen(),));
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Color(0xffC7EDE6)),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 3,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
