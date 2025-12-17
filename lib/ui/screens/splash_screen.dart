import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manage_updated/ui/controller/auth_controller.dart';
import 'package:task_manage_updated/ui/screens/main_bottom_nav_holder_screen.dart';
import '../utils/asset_path.dart';
import '../widgets/screen_background.dart';
import 'sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String name = "/home";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _nextScreen();
  }

  Future _nextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    bool isLoggedIn = await AuthController.isUserLoggedIn();
    if (!mounted) {
      return;
    }

    if (isLoggedIn) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainBottomNav.name,
        (predicate) => false,
      );
    } else {
      Navigator.pushReplacementNamed(context, SignInScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(
            AssetPath.logo,
            height: 120,
            width: 120,
          ),
        ),
      ),
    );
  }
}
