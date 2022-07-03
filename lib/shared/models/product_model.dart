import 'dart:convert';

class ProductModel {
  String id;
  String supplierId;
  String name;
  String description;
  String? category;
  String? image;
  List<dynamic>? gallery;
  String price;
  String? discount;
  String? department;
  String material;
  int quantity = 1;
  bool? hasDiscount = false;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    this.category,
    this.image,
    required this.price,
    this.department,
    required this.material,
    this.gallery,
    this.discount,
    required this.supplierId,
    this.hasDiscount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        supplierId: json['supplier_id'],
        name: json['name'],
        description: json['description'],
        category: json['category'],
        image: json['image'],
        gallery: json['gallery'],
        price: json['price'],
        discount: json['discount'],
        hasDiscount: json['has_discount'],
        department: json['department'],
        material: json['material'],
      );

  static List<ProductModel> allProductFromJson(var str) {
    final jsonData = json.decode(str);
    return List<ProductModel>.from(
        jsonData.map((x) => ProductModel.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'supplier_id': supplierId,
        'name': name,
        'description': description,
        'category': category,
        'image': image,
        'gallery': gallery,
        'price': price,
        'discount': discount,
        'department': department,
        'material': material,
      };
}
