import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage_updated/ui/providers/reset_password_provider.dart';
import 'package:task_manage_updated/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manage_updated/ui/widgets/show_snackbar.dart';
import '../../widgets/screen_background.dart';
import 'sign_in_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  static String name = "/reset-password";

  @override
  State<ResetPassword> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ResetPassword> {
  String? email;
  String? otp;
  final TextEditingController _passrodTEController = TextEditingController();
  final TextEditingController _confirmPassrodTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      email = arguments['email'] as String?;
      otp = arguments['otp'] as String?;

      debugPrint("email == $email");
      debugPrint("otp == $otp");
    }
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
                    "Reset Password",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Minimum length password 8 with letter, number, symbol combination",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passrodTEController,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  TextFormField(
                    controller: _confirmPassrodTEController,
                    decoration: InputDecoration(hintText: "Confirm Password"),
                  ),
                  Consumer<ResetPasswordProvider>(
                    builder: (context, resetPasswordProvider, child) {
                      return Visibility(
                        visible: resetPasswordProvider.inProgress == false,
                        replacement: CenteredProgressIndicator(),
                        child: FilledButton(
                          onPressed: _onTapConfirmButton,
                          child: Text(
                            "Confirm",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      );
                    },
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
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.name,
      (predicate) => false,
    );
  }

  void _onTapConfirmButton() {
    debugPrint("clicked on  button");
    _resetPassord();
  }

  Future<void> _resetPassord() async {
    if (email == null || otp == null) {
      showSnackBar(context, "Email or Otp Missing");
      return;
    }
    if (_passrodTEController.text.isEmpty) {
      showSnackBar(context, "Password is required");
      return;
    }
    if (_passrodTEController.text != _confirmPassrodTEController.text) {
      showSnackBar(context, "Password don't match");
      return;
    }
    final String password = _passrodTEController.text;

    final isSuccess = await context
        .read<ResetPasswordProvider>()
        .resetPasswordProvider(email.toString(), otp.toString(), password);
    if (!mounted) return;

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInScreen.name,
        (predicate) => false,
      );
      showSnackBar(context, "Password Reset done");
      debugPrint("otp :: $otp");
      debugPrint("email :: $email");
      debugPrint("password :: ${_passrodTEController.text}");
    } else {
      showSnackBar(
        context,
        context.read<ResetPasswordProvider>().errorMessage ??
            "Something went wrong",
      );
    }
  }
}
