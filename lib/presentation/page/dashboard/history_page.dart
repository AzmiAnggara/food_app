import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/app_color.dart';
import 'package:food_app/config/app_format.dart';
import 'package:food_app/data/model/order.dart';
import 'package:food_app/data/model/product.dart';
import 'package:food_app/presentation/page/detail_order_page.dart';
import 'package:get/get.dart';

import '../../../config/api.dart';
import '../../controller/c_history.dart';
import '../../controller/c_user.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final cUser = Get.put(CUser());
  final cHistory = Get.put(CHistory());

  @override
  void initState() {
    cHistory.getData(cUser.data.idUser!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        DView.spaceHeight(32),
        Text(
          'Riwayat Pesanan',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        GetBuilder<CHistory>(builder: (_) {
          if (_.listHistory.isEmpty) {
            return DView.empty('Belum Ada Data Order');
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 60),
            itemCount: _.listHistory.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Order order = _.listHistory[index];
              List<Map<String, dynamic>> products =
                  List<Map<String, dynamic>>.from(jsonDecode(order.products));
              String imageCover = products[0]['image'];
              String title = products.length > 1
                  ? '${products[0]['name']} dan ${products.length - 1} Lainnya'
                  : products[0]['name'];
              String total = AppFormat.currency(order.total);
              String date = AppFormat.date(order.createdAt);
              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailOrderPage(order: order));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.fromLTRB(
                    0,
                    index == 0 ? 16 : 10,
                    0,
                    index == 7 ? 16 : 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          '${Api.imageProduct}/taco.jpg',
                          width: 100,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      DView.spaceWidth(8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DView.spaceHeight(8),
                            Text(
                              total,
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColor.primary,
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  date,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        })
      ],
    );
  }
}
