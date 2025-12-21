import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage_updated/ui/providers/add_new_task_provider.dart';
import 'package:task_manage_updated/ui/providers/cancelled_task_list_provider.dart';
import 'package:task_manage_updated/ui/providers/completed_task_list_provider.dart';
import 'package:task_manage_updated/ui/providers/new_task_list_provider.dart';
import 'package:task_manage_updated/ui/providers/progress_task_list_provider.dart';
import 'package:task_manage_updated/ui/providers/sign_in_provider.dart';
import 'package:task_manage_updated/ui/providers/sign_up_provider.dart';
import 'pages/activity_pages/add_new_task.dart';
import 'pages/auth_screen_pages/forget_password_email.dart';
import 'pages/auth_screen_pages/forget_password_otp_verification.dart';
import 'pages/main_pages/main_bottom_nav_holder_screen.dart';
import 'pages/auth_screen_pages/reset_password.dart';
import 'pages/auth_screen_pages/sign_in_screen.dart';
import 'pages/auth_screen_pages/sign_up_screen.dart';
import 'pages/activity_pages/splash_screen.dart';
import 'pages/activity_pages/update_profile.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> SignInProvider()),
        ChangeNotifierProvider(create: (context)=> SignUpProvider()),
        ChangeNotifierProvider(create: (context)=> NewTaskListProvider()),
        ChangeNotifierProvider(create: (context)=> ProgressTaskListProvider()),
        ChangeNotifierProvider(create: (context)=> CancelledTaskListProvider()),
        ChangeNotifierProvider(create: (context)=> CompletedTaskListProvider()),
        ChangeNotifierProvider(create: (context)=> AddNewTaskProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
      
          // TextFormField-->  theme
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
      
          // FilledButtonTheme --> theme
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
              fixedSize: Size.fromWidth(double.maxFinite),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
      
          // TextTHeme
          textTheme: TextTheme(
            headlineLarge: TextStyle(fontWeight: FontWeight.bold),
            labelLarge: TextStyle(color: Colors.grey),
            titleMedium: TextStyle(color: Colors.white),
            titleLarge: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
      
          // scaffold color
          scaffoldBackgroundColor: Colors.green.shade50,
        ),
      
        routes: {
          SplashScreen.name: (context) => const SplashScreen(),
          SignInScreen.name: (context) => const SignInScreen(),
          SignUpScreen.name: (context) => const SignUpScreen(),
          ForgetPasswordEmail.name: (context) => const ForgetPasswordEmail(),
          OtpVerification.name: (context) => const OtpVerification(),
          ResetPassword.name: (context) => const ResetPassword(),
          MainBottomNav.name: (context) => const MainBottomNav(),
          AddNewTask.name: (context) => const AddNewTask(),
          UpdateProfile.name: (context) => const UpdateProfile(),
        },
        initialRoute: SplashScreen.name,
        debugShowCheckedModeBanner: false,
      
        home: SplashScreen(),
      ),
    );
  }
}
