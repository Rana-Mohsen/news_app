import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:news_app/helper/validators.dart';
import 'package:news_app/screens/navigation.dart';
import 'package:news_app/screens/widgets/custom_textformfield.dart';
import 'package:news_app/screens/widgets/custome_button.dart';
import '../constants.dart';
import '../helper/snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

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
                CustomTextFormField(
                  validator: Validators.emailValidator,
                  hintText: 'Email',
                  onChange: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                    validator: Validators.passwordValidator,
                    onChange: (value) {
                      password = value;
                    },
                    hintText: 'Password'),
                const SizedBox(
                  height: 20,
                ),
                CustomeButton(
                  text: 'REGISTER',
                  onTap: _validateForm,
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

  Future<void> _createUser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }

  _validateForm() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      try {
        await _createUser();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Navigation()));
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
  }
}
