import 'package:d_info/d_info.dart';
import 'package:food_app/config/api.dart';
import 'package:food_app/config/app_format.dart';
import 'package:food_app/data/model/product.dart';
import 'package:food_app/presentation/controller/c_cart.dart';
import 'package:food_app/presentation/controller/c_home.dart';
import 'package:food_app/presentation/page/detail_product_page.dart';
import 'package:food_app/presentation/page/list_all_page.dart';
import 'package:food_app/presentation/page/search_page.dart';
import 'package:food_app/presentation/widget/custom_button_icon.dart';
import 'package:get/get.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/app_asset.dart';
import 'package:food_app/config/app_color.dart';
import 'package:food_app/presentation/controller/c_user.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cUser = Get.put(CUser());
  final cHome = Get.put(CHome());
  final cCart = Get.put(CCart());
  final controllerSearch = TextEditingController();

  @override
  void initState() {
    cHome.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DView.spaceHeight(),
        header(),
        DView.spaceHeight(),
        searchField(),
        DView.spaceHeight(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DView.textTitle(
                'Makanan',
                color: Colors.black,
                size: 22,
              ),
              DView.textAction(
                () {
                  Get.to(() => const ListAllPage(type: 'Makanan'));
                },
                text: 'Lihat semua',
                iconRight: Icons.navigate_next,
                color: AppColor.primary,
                iconRightColor: AppColor.primary,
              ),
            ],
          ),
        ),
        DView.spaceHeight(),
        listMakanan(),
        DView.spaceHeight(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DView.textTitle(
                'Minuman',
                color: Colors.black,
                size: 22,
              ),
              DView.textAction(
                () {
                  Get.to(() => const ListAllPage(type: 'Minuman'));
                },
                text: 'Lihat semua',
                iconRight: Icons.navigate_next,
                color: AppColor.primary,
                iconRightColor: AppColor.primary,
              ),
            ],
          ),
        ),
        DView.spaceHeight(),
        listMinuman(),
      ],
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: AppColor.primary,
              ),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                AppAsset.user,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          DView.spaceWidth(),
          Obx(() {
            return Expanded(
              child: Text(
                'Hi,\n${cUser.data.name}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            );
          }),
          DView.spaceWidth(),
          const Text(
            'D\'Licious',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: AppColor.primary),
          ),
        ],
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ),
            DView.spaceWidth(8),
            AspectRatio(
              aspectRatio: 1,
              child: Material(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Get.to(() => SearchPage(query: controllerSearch.text));
                  },
                  child: const Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listMakanan() {
    return SizedBox(
      height: 290,
      child: GetBuilder<CHome>(builder: (_) {
        if (_.listMakanan.isEmpty) return DView.empty('Belum Ada data makanan');
        return ListView.builder(
          itemCount: _.listMakanan.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Product makanan = _.listMakanan[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => DetailProdukPage(product: makanan));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  index == 0 ? 16 : 8,
                  0,
                  index == 2 ? _.listMakanan.length - 1 : 8,
                  0,
                ),
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      child: Image.network(
                        '${Api.imageProduct}/${makanan.image}',
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    DView.spaceHeight(
                      8,
                    ),
                    Text(
                      makanan.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    DView.spaceHeight(
                      4,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppFormat.currency(makanan.price),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                        CustomButtonIcon(
                          onTap: () {
                            cCart.addItem(makanan);
                            DInfo.toastSuccess(
                                'Makanan Berhasil Ditambah ke Keranjang');
                          },
                          icon: Icons.add,
                        ),
                        DView.spaceWidth(8)
                      ],
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

  Widget listMinuman() {
    return SizedBox(
      height: 290,
      child: GetBuilder<CHome>(builder: (_) {
        if (_.listMinuman.isEmpty) return DView.empty('Belum Ada Data Makanan');
        return ListView.builder(
          itemCount: _.listMinuman.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Product minuman = _.listMinuman[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => DetailProdukPage(product: minuman));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  index == 0 ? 16 : 8,
                  0,
                  index == 2 ? 16 : 8,
                  0,
                ),
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      child: Image.network(
                        '${Api.imageProduct}/${minuman.image}',
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    DView.spaceHeight(
                      8,
                    ),
                    Text(
                      minuman.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    DView.spaceHeight(
                      4,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppFormat.currency(minuman.price),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                        CustomButtonIcon(
                          onTap: () {
                            cCart.addItem(minuman);
                            DInfo.toastSuccess(
                                'Minuman Berhasil Ditambah ke Keranjang');
                          },
                          icon: Icons.add,
                        ),
                        DView.spaceWidth(8)
                      ],
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
