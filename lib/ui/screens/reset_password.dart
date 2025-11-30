import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/screen_background.dart';
import 'sign_in_screen.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  static String name = "/reset-password";

  @override
  State<ResetPassword> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ResetPassword> {
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
                  "Reset Password",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  "Minimum length password 8 with letter, number, symbol combination",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                TextFormField(decoration: InputDecoration(hintText: "Password")),
                TextFormField(
                  decoration: InputDecoration(hintText: "Confirm Password"),
                ),
                FilledButton(
                  onPressed: _onTapConfirmButton,
                  child: Text("Confirm", style: Theme.of(context).textTheme.titleMedium,),
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
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.name,
      (predicate) => false,
    );
  }

  void _onTapConfirmButton() {
    debugPrint("Password Reset Done");
  }
}
