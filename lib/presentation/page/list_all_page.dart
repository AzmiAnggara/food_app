import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/api.dart';
import 'package:food_app/config/app_color.dart';
import 'package:food_app/config/app_format.dart';
import 'package:food_app/presentation/controller/c_list_all.dart';
import 'package:get/get.dart';

import '../../data/model/product.dart';
import 'detail_product_page.dart';

class ListAllPage extends StatefulWidget {
  const ListAllPage({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<ListAllPage> createState() => _ListAllPageState();
}

class _ListAllPageState extends State<ListAllPage> {
  final cListAll = Get.put(CListAll());

  @override
  void initState() {
    cListAll.getData(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft(widget.type),
      body: GetBuilder<CListAll>(builder: (_) {
        if (_.listProduct.isEmpty) {
          return DView.empty('Belum Ada Data ${widget.type}');
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
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
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
                        '${Api.imageProduct}/${product.image}',
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      ),
                    ),
                    DView.spaceWidth(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                AppFormat.currency(product.price),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColor.primary),
                              ),
                            ],
                          ),
                          DView.spaceHeight(8),
                          Text(
                            product.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
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
