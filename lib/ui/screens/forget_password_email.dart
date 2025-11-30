import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/screen_background.dart';
import 'forget_password_otp_verification.dart';
import 'sign_in_screen.dart';


class ForgetPasswordEmail extends StatefulWidget {
  const ForgetPasswordEmail({super.key});
  static String name = "/forget-password-email";

  @override
  State<ForgetPasswordEmail> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ForgetPasswordEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
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
                TextFormField(decoration: InputDecoration(hintText: "Email")),
                FilledButton(
                  onPressed: _forgetPasswordEmailButton,
                  child: Icon(Icons.arrow_circle_right_outlined, size: 30),
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
    );
  }

  void _signInButton() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  void _forgetPasswordEmailButton() {
    Navigator.pushNamed(context, OtpVerification.name);
    debugPrint("forget email gotted");
  }
}
