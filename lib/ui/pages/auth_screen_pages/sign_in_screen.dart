import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage_updated/ui/providers/sign_in_provider.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/show_snackbar.dart';
import 'forget_password_email.dart';
import '../main_pages/main_bottom_nav_holder_screen.dart';
import 'sign_up_screen.dart';

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
                    validator: (String? value){
                      if(value?.isEmpty ?? true){
                        return "Enter your password";
                      }
                      if((value!.length) < 6){
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Password"),
                  ),

                  const SizedBox(height: 12),
    
                  Consumer<SignInProvider>(
                    builder: (context, signInProvider, child) {
                      return Visibility(
                        visible: signInProvider.signInProgress == false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: FilledButton(
                          onPressed: _signInButton,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 30,
                          ),
                        ),
                      );
                    },
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
    final isSuccess = await context.read<SignInProvider>().signIn(
      _emailTEController.text.trim(),
      _passwordTEController.text,
    );
    if (!mounted) {
      return;
    }
    if (isSuccess) {
      Navigator.pushReplacementNamed(context, MainBottomNav.name);
      showSnackBar(context, "LogIn Successful.");
    } else {
      showSnackBar(context, context.read<SignInProvider>().errorMessage ?? "Login failed! Please try again.");
    }
  }

  void _signUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  void _forgetButton() {
    Navigator.pushReplacementNamed(context, ForgetPasswordEmail.name);
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}

