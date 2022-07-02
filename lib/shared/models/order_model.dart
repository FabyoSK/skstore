import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.id,
    required this.products,
  });

  final int id;
  final List<Product> products;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  static List<Order> allOrdersFromJson(var str) {
    final jsonData = json.decode(str);
    return List<Order>.from(jsonData.map((x) => Order.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  final int id;
  final String name;
  final String imageUrl;
  final String quantity;
  final String price;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "quantity": quantity,
        "price": price,
      };
}
