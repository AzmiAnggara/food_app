import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/app_asset.dart';
import 'package:food_app/presentation/page/auth/register_pages.dart';
import 'package:food_app/presentation/page/dashboard.dart';
import 'package:get/get.dart';

import '../../../config/app_color.dart';
import '../../../data/source/source_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  login() async {
    if (formKey.currentState!.validate()) {
      bool success = await SourceUser.login(
        controllerEmail.text,
        controllerPassword.text,
      );
      if (success) {
        DInfo.dialogSuccess('Berhasil Login');
        DInfo.closeDialog(actionAfterClose: () {
          Get.off(() => DashboardPage());
        });
      } else {
        DInfo.dialogError('Gagal Login');
        DInfo.closeDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          AppAsset.header,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: LayoutBuilder(builder: (context, constrains) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? constrains.maxHeight - 250
                          : constrains.maxHeight,
                ),
                child: Material(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Column(
                            children: [
                              DView.spaceHeight(12),
                              Container(
                                width: 90,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              DView.spaceHeight(),
                              Text(
                                'Silahkan Login!',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.bold),
                              ),
                              DView.spaceHeight(30),
                              TextFormField(
                                controller: controllerEmail,
                                validator: (value) =>
                                    value == '' ? 'Jangan kosong!' : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  fillColor: AppColor.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Email',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: AppColor.dark,
                                    size: 24,
                                  ),
                                ),
                              ),
                              DView.spaceHeight(),
                              TextFormField(
                                controller: controllerPassword,
                                validator: (value) =>
                                    value == '' ? 'Jangan kosong!' : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: AppColor.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Password',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: AppColor.dark,
                                    size: 24,
                                  ),
                                ),
                              ),
                              DView.spaceHeight(30),
                              Material(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(8),
                                child: InkWell(
                                  onTap: () => login(),
                                  borderRadius: BorderRadius.circular(8),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 16,
                                    ),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Belum punya akun? ',
                              style: TextStyle(fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const RegisterPage());
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        )
      ],
    ));
  }
}
