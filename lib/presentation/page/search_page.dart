import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/api.dart';
import 'package:food_app/config/app_format.dart';
import 'package:food_app/presentation/controller/c_search.dart';
import 'package:get/get.dart';

import '../../config/app_color.dart';
import '../../data/model/product.dart';
import 'detail_product_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final cSearch = Get.put(CSearch());
  final controllerSearch = TextEditingController();

  @override
  void initState() {
    controllerSearch.text = widget.query;
    cSearch.getData(widget.query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(
            right: 16,
          ),
          child: TextField(
            controller: controllerSearch,
            decoration: InputDecoration(
              fillColor: AppColor.secondary,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: 'Cari apa saja',
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  cSearch.getData(controllerSearch.text);
                },
                icon: const Icon(
                  Icons.search,
                  size: 30,
                  color: AppColor.dark,
                ),
              ),
            ),
          ),
        ),
      ),
      body: GetBuilder<CSearch>(builder: (_) {
        if (_.listProduct.isEmpty) {
          return DView.empty('Data Produk tidak ditemukan');
        }
        return ListView.builder(
          itemCount: _.listProduct.length,
          itemBuilder: (context, index) {
            Product product = _.listProduct[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => DetailProdukPage(product: product));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.fromLTRB(
                  16,
                  index == 0 ? 16 : 8,
                  16,
                  index == _.listProduct.length - 1 ? 16 : 8,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(blurRadius: 6, color: Colors.black)
                    ]),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        '${Api.imageProduct}/${product.image}',
                        width: 70,
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
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          DView.spaceHeight(8),
                          Text(
                            AppFormat.currency(product.price),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColor.primary),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
