import 'package:food_app/config/api.dart';
import 'package:food_app/config/app_request.dart';
import 'package:food_app/data/model/product.dart';

class SourceProduct {
  static Future<List<Product>> whereTypeLimit(String type) async {
    String url = '${Api.product}/where_type_limit.php';
    Map? responseBody = await AppRequest.post(url, {
      'type': type,
    });

    if (responseBody == null) {
      return [];
    }

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => Product.fromJson(e)).toList();
    }

    return [];
  }

  static Future<List<Product>> whereType(String type) async {
    String url = '${Api.product}/where_type.php';
    Map? responseBody = await AppRequest.post(url, {
      'type': type,
    });

    if (responseBody == null) {
      return [];
    }

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => Product.fromJson(e)).toList();
    }

    return [];
  }

  static Future<List<Product>> search(String query) async {
    String url = '${Api.product}/search.php';
    Map? responseBody = await AppRequest.post(url, {
      'query': query,
    });

    if (responseBody == null) {
      return [];
    }

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => Product.fromJson(e)).toList();
    }

    return [];
  }
}
