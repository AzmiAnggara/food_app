class Product {
  Product({
    required this.idProduct,
    required this.name,
    required this.type,
    required this.image,
    required this.price,
    required this.description,
    required this.ingredient,
    required this.createdAt,
    required this.updatedAt,
  });

  String idProduct;
  String name;
  String type;
  String image;
  String price;
  String description;
  String ingredient;
  String createdAt;
  String updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        idProduct: json["id_product"],
        name: json["name"],
        type: json["type"],
        image: json["image"],
        price: json["price"],
        description: json["description"] ?? '',
        ingredient: json["ingredient"] ?? '',
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id_product": idProduct,
        "name": name,
        "type": type,
        "image": image,
        "price": price,
        "description": description,
        "ingredient": ingredient,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  Map<String, dynamic> toItemCart() => {
        "id_product": idProduct,
        "name": name,
        "type": type,
        "image": image,
        "price": price,
      };
}
