import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';
import 'package:task_manage_updated/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manage_updated/ui/widgets/show_snackbar.dart';
import '../../widgets/screen_background.dart';
import 'reset_password.dart';
import 'sign_in_screen.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});
  static String name = "/otp-verify";

  @override
  State<OtpVerification> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<OtpVerification> {
  final TextEditingController _otpTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;

  bool _inProgress = false;
  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)?.settings.arguments as String?;
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
                    "Otp Verification",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Enter the 6 digit verification code which given your email address",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),

                  PinCodeTextField(
                    controller: _otpTEController,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    appContext: context,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your OTP";
                      }
                      return null;
                    },
                  ),

                  Visibility(
                    visible: _inProgress == false,
                    replacement: CenteredProgressIndicator(),
                    child: FilledButton(
                      onPressed: _otpVerificationButton,
                      child: Text(
                        "Verify",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
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
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.name,
      (predicate) => false,
    );
  }

  void _otpVerificationButton() {
    _otpVerify();
  }

  Future<void> _otpVerify() async {
    _inProgress = true;
    setState(() {});

    final otp = _otpTEController.text.trim();
    debugPrint("email is ::: $email");
    debugPrint("otp is ::: $otp");

    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.forgetOtpVerifyUrl(email.toString(), otp),
    );
    if (!mounted) return;

    _inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      Navigator.pushReplacementNamed(context, ResetPassword.name, arguments: {
        "email" : email,
        "otp" : otp
      });
      debugPrint("Click on OTP verify button");
    } else {
      showSnackBar(context, response.error);
    }
  }
}
