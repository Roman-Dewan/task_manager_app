import 'package:flutter/material.dart';
import 'package:module18_19/ui/widgets/photo_picker.dart';
import 'package:module18_19/ui/widgets/screen_background.dart';
import 'package:module18_19/ui/widgets/tm_app_bar.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});
  static String name = "/update-profile";
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappBar(fromUpdateProfile: true),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                const SizedBox(height: 32),
                Text("Update Profile", style: TextTheme.of(context).titleLarge),
                SizedBox(height: 2),

                PhotoPicker(),

                TextFormField(decoration: InputDecoration(hintText: "Email")),
                TextFormField(
                  decoration: InputDecoration(hintText: "First Name"),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Last Name"),
                ),
                TextFormField(decoration: InputDecoration(hintText: "Phone")),
                TextFormField(
                  decoration: InputDecoration(hintText: "Password"),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Confirm Password"),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _updateProfile,
                  child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateProfile() {
    debugPrint("profile update done");
  }
}
