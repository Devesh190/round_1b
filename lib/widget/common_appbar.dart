import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key, required this.title});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue.shade50,
      actions: [
        InkWell(
            onTap: () {
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(
              //         builder: (context) => const WelcomeScreen()),
              //     (Route<dynamic> route) => false);
            },
            child:
                Icon(Icons.exit_to_app, color: Colors.blue.shade800, size: 25))
      ],
      title: Text(
        title,
        style:
            TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.w700),
      ),
    );
  }
}
