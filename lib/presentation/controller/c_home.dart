import 'package:food_app/data/model/product.dart';
import 'package:food_app/data/source/source_product.dart';
import 'package:get/get.dart';

class CHome extends GetxController {
  final _listMakanan = <Product>[].obs;
  List<Product> get listMakanan => _listMakanan.value;

  final _listMinuman = <Product>[].obs;
  List<Product> get listMinuman => _listMinuman.value;

  getData() async {
    _listMakanan.value = await SourceProduct.whereTypeLimit('Makanan');
    _listMinuman.value = await SourceProduct.whereTypeLimit('Minuman');
    update();
  }
}
