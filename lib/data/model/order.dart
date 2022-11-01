class Order {
  Order({
    required this.idOrder,
    required this.idUser,
    required this.products,
    required this.total,
    required this.status,
    required this.payment,
    required this.address,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  String idOrder;
  String idUser;
  String products;
  String total;
  String status;
  String payment;
  String address;
  String message;
  String createdAt;
  String updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        idOrder: json["id_order"],
        idUser: json["id_user"],
        products: json["products"],
        total: json["total"],
        status: json["status"],
        payment: json["payment"],
        address: json["address"],
        message: json["message"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_order": idOrder,
        "id_user": idUser,
        "products": products,
        "total": total,
        "status": status,
        "payment": payment,
        "address": address,
        "message": message,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
