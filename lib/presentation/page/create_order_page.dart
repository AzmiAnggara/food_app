import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/session.dart';
import 'package:food_app/data/source/source_order.dart';
import 'package:food_app/presentation/controller/c_address.dart';
import 'package:food_app/presentation/controller/c_dashboard.dart';
import 'package:food_app/presentation/controller/c_user.dart';
import 'package:food_app/presentation/page/change_address_page.dart';
import 'package:food_app/presentation/page/dashboard.dart';
import 'package:food_app/presentation/widget/custom_button.dart';
import 'package:get/get.dart';

import '../../config/app_color.dart';
import '../../config/app_format.dart';
import '../controller/c_cart.dart';

class CreateOrderPage extends StatefulWidget {
  CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final cUser = Get.put(CUser());

  final cCart = Get.put(CCart());

  final cAddress = Get.put(CAddress());

  final cDashboard = Get.put(CDashboard());

  final controllerMessage = TextEditingController();

  final paymentByte = <int>[].obs;

  final paymentName = ''.obs;

  pickPayment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);

    if (result != null) {
      if (result.files.single.path != null) {
        File file = File(result.files.single.path!);
        paymentByte.value = file.readAsBytesSync();
        paymentName.value =
            '${DateTime.now().microsecondsSinceEpoch}_${result.files.single.name}';
      }
    }
  }

  createOrderNow() async {
    bool success = await SourceOrder.add(
      cUser.data.idUser!,
      jsonEncode(cCart.listItem),
      cCart.total.toString(),
      paymentName.value,
      base64Encode(paymentByte.value),
      cAddress.data,
      controllerMessage.text,
    );

    if (success) {
      cCart.restart();
      cDashboard.indexNav = 2;
      DInfo.dialogSuccess('Berhasil Membuat Pesanan');
      DInfo.closeDialog(actionAfterClose: () {
        Get.offAll(() => DashboardPage());
      });
    } else {
      DInfo.dialogError('Gagal Membuat Pesanan');
      DInfo.closeDialog();
    }
  }

  @override
  void initState() {
    Session.getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Buat Pesanan'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
            label: 'Pesan Sekarang',
            onTab: () {
              createOrderNow();
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            DView.textTitle(
              'Pembayaran',
              color: Colors.black,
              size: 20,
            ),
            DView.spaceHeight(),
            Obx(() {
              return Text('''
BNI - 111111111
Atas Nama D'Licios
${AppFormat.currency(cCart.total.toString())}
''');
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DView.textTitle(
                  'Alamat',
                  color: Colors.black,
                  size: 20,
                ),
                DView.textAction(
                  () {
                    Get.to(() => ChangeAddressPage(
                          oldAddress: cAddress.data,
                        ));
                  },
                  text: 'Ubah Alamat',
                  color: AppColor.primary,
                ),
              ],
            ),
            DView.spaceHeight(8),
            Obx(() {
              if (cAddress.data == '') {
                return DView.error(
                    'Data alamat belum ada, silahkan isi di tombol ubah alamat');
              }
              return Text(
                cAddress.data,
                maxLines: 8,
                textAlign: TextAlign.justify,
              );
            }),
            DView.spaceHeight(8),
            TextField(
              controller: controllerMessage,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pesan ...',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
            DView.spaceHeight(8),
            DView.textTitle(
              'Upload Bukti Pembayaran',
              color: Colors.black,
              size: 20,
            ),
            DView.spaceHeight(8),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => pickPayment(),
                  child: const Text('Pilih Foto'),
                ),
              ),
            ),
            DView.spaceHeight(8),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(40)),
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Obx(() {
                    if (paymentByte.value.isEmpty) {
                      return const Text('Belum ada foto');
                    }
                    return Image.memory(
                      Uint8List.fromList(paymentByte.value),
                      fit: BoxFit.fitHeight,
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
