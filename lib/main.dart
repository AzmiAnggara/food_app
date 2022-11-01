import 'package:flutter/material.dart';
import 'package:food_app/config/session.dart';
import 'package:food_app/presentation/page/auth/login_pages.dart';
import 'package:food_app/presentation/page/dashboard.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';

import 'config/app_color.dart';
import 'data/model/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id_ID').then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light(
            primary: AppColor.primary,
            secondary: AppColor.secondary,
          ),
          scaffoldBackgroundColor: AppColor.bgScaffold,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
          ),
        ),
        home: FutureBuilder(
          future: Session.getUser(),
          builder: ((context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.data != null && snapshot.data!.idUser != null) {
              return DashboardPage();
            }
            return LoginPage();
          }),
        ));
  }
}
