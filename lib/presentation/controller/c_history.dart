import 'package:get/get.dart';

import '../../data/model/order.dart';
import '../../data/source/source_order.dart';

class CHistory extends GetxController {
  final _listHistory = <Order>[].obs;

  List<Order> get listHistory => _listHistory.value;

  getData(String idUser) async {
    _listHistory.value = await SourceOrder.history(idUser);
    update();
  }
}
