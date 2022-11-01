import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

import 'package:food_app/config/api.dart';
import 'package:food_app/config/app_asset.dart';
import 'package:food_app/config/app_color.dart';
import 'package:food_app/config/app_format.dart';
import 'package:food_app/data/model/product.dart';
import 'package:food_app/presentation/widget/custom_button.dart';
import 'package:get/get.dart';

import '../controller/c_cart.dart';

class DetailProdukPage extends StatelessWidget {
  DetailProdukPage({Key? key, required this.product}) : super(key: key);
  final Product product;
  final cCart = Get.put(CCart());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomButton(
            label: 'Masukkan Ke Keranjang',
            onTab: () {
              cCart.addItem(product);
              DInfo.toastSuccess('Berhasil Ditambah ke Keranjang');
            }),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(0),
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.network(
                  '${Api.imageProduct}/${product.image}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(),
                    DView.spaceHeight(8),
                    Text(
                      AppFormat.currency(product.price),
                      style: const TextStyle(
                        fontSize: 24,
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DView.spaceHeight(20),
                    const Text(
                      'Bahan - bahan',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    DView.spaceHeight(8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.ingredient.split(', ').map((e) {
                        return Chip(
                          label: Text(
                            e,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: AppColor.secondary,
                        );
                      }).toList(),
                    ),
                    DView.spaceHeight(10),
                    Text(
                      product.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: kToolbarHeight,
            left: 16,
            child: Material(
              elevation: 8,
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              child: const BackButton(),
            ),
          ),
        ],
      ),
    );
  }

  Row title() {
    return Row(
      children: [
        Expanded(
          child: Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        DView.spaceWidth(8),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Material(
            color: AppColor.secondary,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 18,
                    color: AppColor.primary,
                  ),
                  DView.spaceWidth(4),
                  const Text(
                    '4,5',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.dark,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
