import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:news_app/helper/validators.dart';
import 'package:news_app/screens/navigation.dart';
import 'package:news_app/screens/register_screen.dart';
import 'package:news_app/screens/widgets/custome_button.dart';
import 'package:sizer/sizer.dart';

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
  bool visible = true;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 3,
                ),
                Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                CustomTextFormField(
                    validator: Validators.emailValidator,
                    onChange: (value) {
                      email = value;
                    },
                    hintText: 'Email'),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                    obscure: visible,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        icon: visible
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                      ),
                    ),
                    validator: Validators.passwordValidator,
                    onChange: (value) {
                      password = value;
                    },
                    hintText: 'Password'),
                const SizedBox(
                  height: 30,
                ),
                CustomeButton(
                  onTap: _validateLoginForm,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ));
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: kTertiaryColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signInUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  _validateLoginForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await _signInUser();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Navigation(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        _handleFirebaseAuthException(e);
      } catch (e) {
        _handleGenericException(e);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _handleFirebaseAuthException(FirebaseAuthException e) {
    print(e);

    if (e.code == "wrong-password") {
      snackBarMessage(context, "Your password is wrong");
    } else if (e.code == "user-not-found") {
      snackBarMessage(context, "User not found");
    }
  }

  void _handleGenericException(e) {
    print(e);
    snackBarMessage(context, "There was an error");
  }
}
