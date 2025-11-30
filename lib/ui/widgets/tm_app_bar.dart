import 'package:flutter/material.dart';
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
            const CircleAvatar(),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Md. Roman Dewan",
                  style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                Text(
                  "roman.dewan@gmail.com",
                  style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
