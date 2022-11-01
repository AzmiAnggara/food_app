import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/api.dart';
import 'package:food_app/config/app_color.dart';
import 'package:food_app/config/app_format.dart';
import 'package:food_app/presentation/controller/c_cart.dart';
import 'package:food_app/presentation/page/create_order_page.dart';
import 'package:food_app/presentation/widget/custom_button_icon.dart';
import 'package:get/get.dart';

import '../../../data/model/product.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);
  final cCart = Get.put(CCart());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DView.spaceHeight(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Keranjang',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  DInfo.toastNetral('Geser Ke Kiri Untuk Menghapus Pesanan');
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.orange.shade900,
                ),
              )
            ],
          ),
        ),
        // DView.spaceHeight(),
        GetBuilder<CCart>(builder: (_) {
          if (_.listItem.isEmpty) {
            return DView.empty('Belum ada Pesanan');
          }
          return ListView.builder(
            itemCount: _.listItem.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              int qty = _.listItem[index]['qty'];
              Product product = Product.fromJson(_.listItem[index]);
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (DismissDirection dismissDirection) {
                  _.deleteItem(product.idProduct);
                  DInfo.toastSuccess('Pesanan Dihapus');
                },
                background: Container(
                  padding: const EdgeInsets.only(
                    right: 16,
                  ),
                  alignment: Alignment.centerRight,
                  color: Colors.red.shade400,
                  child: const Text(
                    'Hapus',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    index == 0 ? 16 : 8,
                    16,
                    index == 4 ? _.listItem.length - 1 : 8,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          '${Api.imageProduct}/${product.image}',
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      DView.spaceWidth(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            DView.spaceHeight(8),
                            Text(
                              AppFormat.currency(product.price),
                              style: const TextStyle(
                                color: AppColor.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomButtonIcon(
                        onTap: () {
                          cCart.minusQty(product.idProduct);
                        },
                        icon: Icons.remove,
                      ),
                      DView.spaceWidth(8),
                      Text(
                        '$qty',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      DView.spaceWidth(8),
                      CustomButtonIcon(
                        onTap: () {
                          cCart.plusQty(product.idProduct);
                        },
                        icon: Icons.add,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
        Obx(() {
          if (cCart.total == 0) {
            return DView.nothing();
          }
          return Padding(
            padding: const EdgeInsets.all(
              16,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              color: AppColor.primary,
              elevation: 8,
              child: InkWell(
                onTap: () {
                  Get.to(() => CreateOrderPage());
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            DView.spaceHeight(4),
                            Text(
                              AppFormat.currency(cCart.total.toString()),
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const Text(
                        'Buat Pesanan',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        })
      ],
    );
  }
}
