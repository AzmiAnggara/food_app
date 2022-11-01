import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/session.dart';
import 'package:get/get.dart';

import '../widget/custom_button.dart';

class ChangeAddressPage extends StatelessWidget {
  const ChangeAddressPage({Key? key, required this.oldAddress})
      : super(key: key);
  final String? oldAddress;

  @override
  Widget build(BuildContext context) {
    final controllerAddress = TextEditingController(text: oldAddress ?? '');
    return Scaffold(
      appBar: DView.appBarLeft('Ubah Alamat'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DInput(
              controller: controllerAddress,
              hint: 'Masukkan Alamat',
              minLine: 1,
              maxLine: 8,
            ),
            DView.spaceHeight(),
            CustomButton(
                label: 'Simpan',
                onTab: () {
                  DInfo.dialogConfirmation(context, 'Simpan Alamant',
                          'Klik Yes untuk Konfirmasi')
                      .then((yes) {
                    if (yes ?? false) {
                      Session.saveAddress(controllerAddress.text)
                          .then((success) {
                        Get.back();
                      });
                    }
                  });
                }),
          ],
        ),
      ),
    );
  }
}
