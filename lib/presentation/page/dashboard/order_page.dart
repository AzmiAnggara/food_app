import 'dart:convert';

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/config/api.dart';
import 'package:food_app/data/model/order.dart';
import 'package:food_app/presentation/controller/c_order.dart';
import 'package:food_app/presentation/controller/c_user.dart';
import 'package:food_app/presentation/page/detail_order_page.dart';
import 'package:get/get.dart';

import '../../../config/app_color.dart';
import '../../../config/app_format.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final cUser = Get.put(CUser());
  final cOrder = Get.put(COrder());

  @override
  void initState() {
    cOrder.getData(cUser.data.idUser!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        DView.spaceHeight(32),
        Text(
          'Pesanan Kamu',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        GetBuilder<COrder>(builder: (_) {
          if (_.listOrder.isEmpty) {
            return DView.empty('Belum Ada Data Order');
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 60),
            itemCount: _.listOrder.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Order order = _.listOrder[index];
              List<Map<String, dynamic>> products =
                  List<Map<String, dynamic>>.from(jsonDecode(order.products));
              String title = products.length > 1
                  ? '${products[0]['name']} dan ${products.length - 1} Lainnya'
                  : products[0]['name'];
              String imageCover = products[0]['image'];
              String total = AppFormat.currency(order.total);
              String date = AppFormat.date(order.createdAt);
              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailOrderPage(
                        order: order,
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.fromLTRB(
                    0,
                    index == 0 ? 16 : 10,
                    0,
                    index == _.listOrder.length - 1 ? 16 : 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          '${Api.imageProduct}/${imageCover}',
                          height: 70,
                          width: 70,
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
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            DView.spaceHeight(8),
                            Text(
                              total,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColor.primary),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                date,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
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
