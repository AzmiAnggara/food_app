import 'package:food_app/data/model/product.dart';
import 'package:get/get.dart';

class CCart extends GetxController {
  final _listItem = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> get listItem => _listItem.value;

  final _total = 0.0.obs;
  double get total => _total.value;
  set total(double n) {
    _total.value = n;
  }

  addItem(Product newProduct) {
    int index =
        _listItem.indexWhere((e) => e['id_product'] == newProduct.idProduct);
    // Tambah Qty Baru
    if (index < 0) {
      Map<String, dynamic> item = newProduct.toItemCart();
      item['qty'] = 1;
      _listItem.add(item);
    } else {
      // Update Qty
      _listItem[index]['qty'] += 1;
    }
    count();
  }

  plusQty(String idProduct) {
    int index = _listItem.indexWhere((e) => e['id_product'] == idProduct);
    _listItem[index]['qty'] += 1;
    count();
  }

  minusQty(String idProduct) {
    int index = _listItem.indexWhere((e) => e['id_product'] == idProduct);
    if (_listItem[index]['qty'] >= 2) {
      _listItem[index]['qty'] -= 1;
      count();
    }
  }

  deleteItem(String id) {
    _listItem.removeWhere((e) => e['id_product'] == id);
    count();
  }

  count() {
    double currentTotal = 0.0;
    for (var e in listItem) {
      double price = double.parse(e['price']);
      int qty = e['qty'];
      double totalProduk = price * qty;
      currentTotal += totalProduk;
    }

    total = currentTotal;
    update();
  }

  restart() {
    total = 0.0;
    listItem.clear();
  }
}
