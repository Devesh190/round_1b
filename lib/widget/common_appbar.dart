import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../feature/login_signup/provider/auth_provider.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar(
      {super.key,
      required this.title,
      required this.showIcon,
      required this.titleStyle,
      required this.color});
  final String title;
  final TextStyle titleStyle;
  final Color color;
  final bool showIcon;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      actions: showIcon
          ? [
              InkWell(
                  onTap: () {
                    final provider =
                        Provider.of<AuthProvider>(context, listen: false);

                    provider.logout(context);
                  },
                  child: Icon(Icons.exit_to_app, color: Colors.white, size: 25))
            ]
          : [],
      title: Text(title, style: titleStyle),
    );
  }
}
