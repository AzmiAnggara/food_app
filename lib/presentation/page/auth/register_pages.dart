import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/app_asset.dart';
import 'package:food_app/config/app_color.dart';

import 'package:get/get.dart';

import '../../../data/source/source_user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  register() async {
    if (formKey.currentState!.validate()) {
      await SourceUser.register(
        controllerName.text,
        controllerEmail.text,
        controllerPassword.text,
      );
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? constraints.maxHeight - 250
                          : constraints.maxHeight,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
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
                                    'Buat Akun',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          color: AppColor.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  DView.spaceHeight(30),
                                  TextFormField(
                                    controller: controllerName,
                                    validator: (value) =>
                                        value == '' ? 'Jangan kosong' : null,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      fillColor: AppColor.secondary,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'name',
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 16,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: AppColor.dark,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  DView.spaceHeight(),
                                  TextFormField(
                                    controller: controllerEmail,
                                    validator: (value) =>
                                        value == '' ? 'Jangan kosong' : null,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      fillColor: AppColor.secondary,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'email',
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                        value == '' ? 'Jangan kosong' : null,
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
                                      hintText: 'password',
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      onTap: () {
                                        register();
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 16),
                                        child: Text(
                                          'REGISTER',
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
                                  'Sudah punya akun? ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
