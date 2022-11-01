import 'package:food_app/data/model/order.dart';
import 'package:food_app/data/source/source_order.dart';
import 'package:get/get.dart';

class COrder extends GetxController {
  final _listOrder = <Order>[].obs;

  List<Order> get listOrder => _listOrder.value;

  getData(String idUser) async {
    _listOrder.value = await SourceOrder.whereProccess(idUser);
    update();
  }
}
