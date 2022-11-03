import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/config/api.dart';
import 'package:food_app/config/app_color.dart';
import 'package:food_app/config/app_format.dart';
import 'package:food_app/data/model/order.dart';
import 'package:food_app/data/source/source_order.dart';
import 'package:get/get.dart';

class DetailOrderPage extends StatelessWidget {
  const DetailOrderPage({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products =
        List<Map<String, dynamic>>.from(jsonDecode(order.products));

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text('Detail Pesanan'),
        actions: [
          Center(
            child: Text(
              order.status,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          DView.spaceWidth()
        ],
      ),
      floatingActionButton: order.status != 'Diterima'
          ? null
          : FloatingActionButton(
              onPressed: () async {
                bool? yes = await DInfo.dialogConfirmation(
                  context,
                  'Hapus Riwayat Pesanan',
                  'Klik Yes Jika Benar',
                );
                if (yes ?? false) {
                  bool succes = await SourceOrder.deleteHistory(
                      order.idOrder, order.payment);
                  if (succes) {
                    DInfo.dialogSuccess('Berhasil Hapus Pesanan');
                    DInfo.closeDialog(actionAfterClose: () {
                      Get.back(result: true);
                    });
                  } else {
                    DInfo.dialogError('Gagal Hapus Riwayat');
                    DInfo.closeDialog();
                  }
                }
              },
              backgroundColor: Colors.red,
              child: const Icon(
                Icons.delete,
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DView.textTitle(
                  'ID: ${order.idOrder}',
                  size: 20,
                  color: Colors.black,
                  weight: FontWeight.normal,
                ),
                Text(
                  AppFormat.date(order.createdAt),
                )
              ],
            ),
            DView.spaceHeight(24),
            DView.textTitle(
              'Alamat',
              size: 20,
              color: Colors.black,
            ),
            DView.spaceHeight(8),
            Text(
              order.address,
              // maxLines: 3,
              // overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
              ),
              textAlign: TextAlign.justify,
            ),
            DView.spaceHeight(24),
            DView.textTitle(
              'Pesan',
              size: 20,
              color: Colors.black,
            ),
            DView.spaceHeight(8),
            Text(
              order.message,
              // maxLines: 3,
              // overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
              ),
              textAlign: TextAlign.justify,
            ),
            DView.spaceHeight(24),
            DView.textTitle(
              'Produk',
              size: 20,
              color: Colors.black,
            ),
            ListView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                String imageCover = products[index]['image'];
                String title = products[index]['name'];
                String price = AppFormat.currency(products[index]['price']);
                int qty = products[index]['qty'];
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    index == 0 ? 16 : 8,
                    0,
                    index == products.length - 1 ? 16 : 8,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          '${Api.imageProduct}/$imageCover',
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      DView.spaceWidth(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            DView.spaceHeight(8),
                            Text(
                              price,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'x$qty',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              },
            ),
            DView.spaceHeight(24),
            DView.textTitle(
              'Total',
              size: 20,
              color: Colors.black,
            ),
            DView.spaceHeight(8),
            DView.textTitle(
              AppFormat.currency(order.total),
              size: 25,
              color: AppColor.primary,
            ),
            DView.spaceHeight(24),
            Center(
              child: DView.textTitle(
                'Pembayaran',
                size: 20,
                color: Colors.black,
              ),
            ),
            DView.spaceHeight(8),
            AspectRatio(
              aspectRatio: 1,
              child: Align(
                alignment: Alignment.center,
                child: Image.network(
                  '${Api.imagePayment}/${order.payment}',
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
