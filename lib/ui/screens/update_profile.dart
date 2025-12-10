import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manage_updated/data/models/user_model.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';
import 'package:task_manage_updated/ui/controller/auth_controller.dart';
import 'package:task_manage_updated/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manage_updated/ui/widgets/show_snackbar.dart';
import '../widgets/photo_picker.dart';
import '../widgets/screen_background.dart';
import '../widgets/tm_app_bar.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});
  static String name = "/update-profile";
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    final UserModel userModel = AuthController.user!;
    _emailTEController.text = userModel.email;
    _firstNameTEController.text = userModel.firstName;
    _lastNameTEController.text = userModel.lastName;
    _mobileTEController.text = userModel.mobiile;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappBar(fromUpdateProfile: true),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),

            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    "Update Profile",
                    style: TextTheme.of(context).titleLarge,
                  ),
                  SizedBox(height: 2),

                  GestureDetector(
                    onTap: _pickImage,
                    child: PhotoPicker(pickedImage: _pickedImage),
                  ),

                  TextFormField(
                    enabled: false,
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: "Email"),
                  ),

                  TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your firstName";
                      }
                      return null;
                    },
                    controller: _firstNameTEController,
                    decoration: InputDecoration(hintText: "First Name"),
                  ),

                  TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your lastName";
                      }
                      return null;
                    },
                    controller: _lastNameTEController,
                    decoration: InputDecoration(hintText: "Last Name"),
                  ),

                  TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your phone";
                      }
                      return null;
                    },
                    controller: _mobileTEController,
                    decoration: InputDecoration(hintText: "Phone"),
                  ),

                  TextFormField(
                    validator: (String? value) {
                      final password = value ?? '';
                      if (password.isNotEmpty && password.length < 6) {
                        return "Enter password at least 6 character";
                      }
                      return null;
                    },
                    controller: _passwordTEController,
                    decoration: InputDecoration(hintText: "Password"),
                  ),

                  const SizedBox(height: 8),
                  Visibility(
                    visible: _updateProfileInProgress == false,
                    replacement: CenteredProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTapUpdateProfile,
                      child: Icon(Icons.arrow_circle_right_outlined, size: 30),
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

  Future<void> _pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _pickedImage = image;
    }
    setState(() {});
  }

  void _onTapUpdateProfile() {
    debugPrint("profile update done");
    if (_formKey.currentState!.validate()) {
      updateProfile();
    }
  }

  Future<void> updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text,
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }
    if (_pickedImage != null) {
      Uint8List imageBytes = await _pickedImage!.readAsBytes();
      requestBody['photo'] = jsonEncode(imageBytes);
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.updateProfileUrl,
      body: requestBody,
    );

    if (!mounted) return;
    if (response.isSuccess) {
      requestBody["_id"] = AuthController.user!.id;
      showSnackBar(context, "Profile has been updated!");
      await AuthController.updateProfileData(UserModel.fromJson(requestBody));
    } else {
      showSnackBar(context, response.error);
    }

     _updateProfileInProgress = false;
    setState(() {});
  }
}
