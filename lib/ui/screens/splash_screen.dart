import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    if (context.mounted) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, SignInScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(child: SvgPicture.asset(AssetPath.logo)),
      ),
    );
  }
}
