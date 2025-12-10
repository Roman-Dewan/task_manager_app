
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manage_updated/ui/controller/auth_controller.dart';
import 'package:task_manage_updated/ui/screens/sign_in_screen.dart';
import 'package:task_manage_updated/ui/widgets/show_snackbar.dart';
import '../screens/update_profile.dart';

class TMappBar extends StatelessWidget implements PreferredSizeWidget {
  const TMappBar({super.key, this.fromUpdateProfile = false});
  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (fromUpdateProfile) {
            return;
          }
          Navigator.pushNamed(context, UpdateProfile.name);
          debugPrint("click done");
        },
        child: Row(
          children: [
            CircleAvatar(
              child: AuthController.user!.photo.isEmpty
                  ? Icon(Icons.person)
                  : Image.memory(base64Decode(AuthController.user!.photo)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.user?.fullName ?? '',
                  style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                Text(
                  AuthController.user?.email ?? '',
                  style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await AuthController.clearUserData();
            Navigator.pushNamedAndRemoveUntil(
              // ignore: use_build_context_synchronously
              context,
              SignInScreen.name,
              (predicate) => false,
            );
            // ignore: use_build_context_synchronously
            showSnackBar(context, "Logout Successful!!");
          },
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
