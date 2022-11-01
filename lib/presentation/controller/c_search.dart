import 'package:food_app/data/model/product.dart';
import 'package:food_app/data/source/source_product.dart';
import 'package:get/get.dart';

class CSearch extends GetxController {
  final _listProduct = <Product>[].obs;

  List<Product> get listProduct => _listProduct.value;

  getData(String query) async {
    _listProduct.value = await SourceProduct.search(query);
    update();
  }
}
