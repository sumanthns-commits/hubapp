import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HubDrawer extends StatelessWidget {
  final bool isLoggedIn;

  final void Function() logoutAction;

  const HubDrawer(
      {Key? key, required this.isLoggedIn, required this.logoutAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          if (isLoggedIn)
            TextButton(
              onPressed: logoutAction,
              child: Text(
                'Logout',
              ),
            )
        ],
      ),
    );
  }
}
