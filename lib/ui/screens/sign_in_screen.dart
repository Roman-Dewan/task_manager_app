import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:module18_19/data/services/network_caller.dart';
import 'package:module18_19/data/utils/urls.dart';
import 'package:module18_19/ui/screens/forget_password_email.dart';
import 'package:module18_19/ui/screens/main_bottom_nav_holder_screen.dart';
import 'package:module18_19/ui/screens/sign_up_screen.dart';
import 'package:module18_19/ui/widgets/screen_background.dart';
import 'package:module18_19/ui/widgets/show_snackbar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static String name = "/sign-in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 64),
                  Text(
                    "Get Started With",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your email";
                      }
                      if (EmailValidator.validate(value!) == false) {
                        return "Enter valid email address";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  const SizedBox(height: 12),
                  Visibility(
                    visible: _signInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: FilledButton(
                      onPressed: _signInButton,
                      child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _forgetButton,
                          child: Text("Forget Password?"),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            text: "Don't have an account? ",

                            children: <TextSpan>[
                              TextSpan(
                                text: "sign up",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _signUpButton,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signInButton() {
    debugPrint("Login done.");
    if (_formKey.currentState!.validate()) {
      signIn();
    }
  }

  Future<void> signIn() async {
    _signInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text.trim(),
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.loginUrl,
      body: requestBody,
    );
    if (!mounted) {
      return;
    }
    _signInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      // _clearText();
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainBottomNav.name,
        (predicate) => false,
      );
      showSnackBar(context, "LogIn Successful.");
    } else {
      showSnackBar(context, response.error);
    }
  }

  void _signUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  void _forgetButton() {
    Navigator.pushReplacementNamed(context, ForgetPasswordEmail.name);
  }
}
