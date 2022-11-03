import 'package:food_app/config/api.dart';
import 'package:food_app/config/app_request.dart';
import 'package:food_app/data/model/order.dart';

class SourceOrder {
  static Future<bool> add(
    String idUser,
    String products,
    String total,
    String payment,
    String paymentBase64,
    String address,
    String message,
  ) async {
    String url = '${Api.order}/add.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'products': products,
      'total': total,
      'payment': payment,
      'payment_base64': paymentBase64,
      'address': address,
      'message': message,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    if (responseBody == null) return false;

    return responseBody['success'];
  }

  static Future<List<Order>> whereProccess(String idUser) async {
    String url = '${Api.order}/where_proccess.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => Order.fromJson(e)).toList();
    }

    return [];
  }

  static Future<List<Order>> history(String idUser) async {
    String url = '${Api.order}/history.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => Order.fromJson(e)).toList();
    }

    return [];
  }

  static Future<bool> deleteHistory(
    String idOrder,
    String payment,
  ) async {
    String url = '${Api.order}/delete_history.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_order': idOrder,
      'payment': payment,
    });

    if (responseBody == null) return false;

    return responseBody['success'];
  }
}
