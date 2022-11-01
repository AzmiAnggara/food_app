import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/session.dart';
import '../auth/login_pages.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (() {
            Get.off(() => LoginPage());
            Session.clearUser();
          }),
          child: Text('Logout'),
        ),
      ),
    );
  }
}
