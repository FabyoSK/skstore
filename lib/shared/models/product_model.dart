import 'dart:convert';

class ProductModel {
  String id;
  String name;
  String description;
  String category;
  String image;
  String price;
  String department;
  String material;
  int quantity = 1;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.image,
      required this.price,
      required this.department,
      required this.material});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        category: json['category'],
        image: json['image'],
        price: json['price'],
        department: json['department'],
        material: json['material'],
      );

  static List<ProductModel> allProductFromJson(var str) {
    final jsonData = json.decode(str);
    return List<ProductModel>.from(
        jsonData.map((x) => ProductModel.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "category": category,
        "image": image,
        "price": price,
        "material": material,
        "department": department,
      };

  void setQuantity(newQuantity) {
    quantity = newQuantity;
  }
}
