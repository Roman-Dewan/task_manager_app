import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';
import 'package:task_manage_updated/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manage_updated/ui/widgets/show_snackbar.dart';
import '../../widgets/screen_background.dart';
import 'forget_password_otp_verification.dart';
import 'sign_in_screen.dart';

class ForgetPasswordEmail extends StatefulWidget {
  const ForgetPasswordEmail({super.key});
  static String name = "/forget-password-email";

  @override
  State<ForgetPasswordEmail> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ForgetPasswordEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  bool _forgetPasswordInProgress = false;
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
                    "Your Email Address",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "A 6 digit verification pin will sent to your email address",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
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
                  Visibility(
                    visible: _forgetPasswordInProgress == false,
                    replacement: CenteredProgressIndicator(),
                    child: FilledButton(
                      onPressed: _forgetPasswordEmailButton,
                      child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                    ),
                  ),

                  const SizedBox(height: 24),

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
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  void _forgetPasswordEmailButton() {
    if (_formKey.currentState!.validate()) {
      _forgetPassword();
    }
    debugPrint("click on forget email button");
  }

  Future<void> _forgetPassword() async {
    _forgetPasswordInProgress = true;
    setState(() {});

    final email = _emailTEController.text.trim();
    debugPrint("Email is :: $email");
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.forgetPasswordEmailUrl(email),
    );

    _forgetPasswordInProgress = false;
    setState(() {});

    if (!mounted) return;

    if (response.isSuccess) {
      debugPrint("succesful");
      Navigator.pushNamed(context, OtpVerification.name, arguments: email);
    } else {
      showSnackBar(context, response.error);
    }
  }
}
