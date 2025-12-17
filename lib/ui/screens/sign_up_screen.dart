import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage_updated/ui/providers/sign_up_provider.dart';
import '../widgets/screen_background.dart';
import '../widgets/show_snackbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String name = "/sign-up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),

            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  Text(
                    "Join With US",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16),
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
                    controller: _firstNameTEController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your First Name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "First Name"),
                  ),
                  TextFormField(
                    controller: _lastNameTEController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your Last Name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Last Name"),
                  ),
                  TextFormField(
                    controller: _mobileTEController,
                    keyboardType: TextInputType.phone,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your mobile number";
                      }
                      if (value!.length < 11) {
                        return "Mobile number must be 11 digit";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Mobile"),
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your password";
                      }
                      if (value!.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  Consumer<SignUpProvider>(
                    builder: (context, signUpProvider, child) {
                      return Visibility(
                        visible: signUpProvider.signInProgress == false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: FilledButton(
                          onPressed: _onTapSignUpButton,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 30,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            text: "Have an account? ",
                            children: <TextSpan>[
                              TextSpan(
                                text: "sign In",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _signInButton,
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
    Navigator.pop(context);
  }

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    final isSuccess = await context.read<SignUpProvider>().signUp(
      _emailTEController.text.trim(),
      _firstNameTEController.text.trim(),
      _lastNameTEController.text.trim(),
      _mobileTEController.text.trim(),
      _passwordTEController.text,
    );

    if (!mounted) {
      return;
    }
    if (isSuccess) {
      _clearText();
      showSnackBar(context, "Registration SuccessFull, Please Login.");
    } else {
      showSnackBar(
        context,
        context.read<SignUpProvider>().errorMessage ??
            "Registration Unsuccessful",
      );
    }
  }

  void _clearText() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
  }
}
