import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/navigation.dart';
import 'package:news_app/screens/widgets/custom_textformfield.dart';
import 'package:news_app/screens/widgets/custome_button.dart';
import '../constants.dart';
import '../helper/snack_bar.dart';
import 'widgets/custome_textfield.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
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
                      "REGISTER",
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
                  hintText: 'Email',
                  onChange: (value) {
                    email = value;
                  },
                ),
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
                  text: 'REGISTER',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await createUser();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Navigation()));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "weak_password") {
                          snackBarMessage(context, "your password is weak");
                        } else if (e.code == "email-already-in-use") {
                          snackBarMessage(context, "email is already in use");
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
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
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
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
      ),
    );
  }

  Future<void> createUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
