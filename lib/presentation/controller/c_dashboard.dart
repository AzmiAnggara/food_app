import 'package:get/get.dart';

class CDashboard extends GetxController {
  final _indexNav = 0.obs;
  int get indexNav => _indexNav.value;
  set indexNav(n) {
    _indexNav.value = n;
  }
}
