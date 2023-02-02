// To parse this JSON data, do
//
//     final productCategoryDataModel = productCategoryDataModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

ProductCategoryDataModel productCategoryDataModelFromJson(String str) =>
    ProductCategoryDataModel.fromJson(json.decode(str));

String productCategoryDataModelToJson(ProductCategoryDataModel data) =>
    json.encode(data.toJson());

class ProductCategoryDataModel {
  ProductCategoryDataModel({
    required this.status,
    required this.data,
    required this.categoriesCount,
  });

  String status;
  List<Datum> data;
  int categoriesCount;

  factory ProductCategoryDataModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryDataModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        categoriesCount: json["categories_count"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "categories_count": categoriesCount,
      };
}

class Datum {
  Datum({
    required this.categoryId,
    required this.categoryName,
    required this.products,
  });

  int categoryId;
  String categoryName;
  List<Product> products;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.kitchenItemId,
    required this.kitchenItemName,
    required this.kitchenItemImage,
    required this.kitchenItemAmount,
    required this.productsStatus,
    required this.itemPackagingCharge,
    required this.busaddress,
    required this.userId,
    required this.itemDiscountPrice,
    required this.productsTempQuantity,
    required this.productsMaxQuantity,
    required this.productsQuantity,
    required this.buyStatus,
    required this.placeorderType,
    required this.mode,
    required this.businessStatus,
    required this.verificationStatus,
    required this.businessDrawerStatus,
    required this.isDeliver,
    required this.isCart,
    required this.productsType,
  });

  int kitchenItemId;
  String kitchenItemName;
  List<KitchenItemImage> kitchenItemImage;
  int kitchenItemAmount;
  int productsStatus;
  int itemPackagingCharge;
  Busaddress busaddress;
  int userId;
  int itemDiscountPrice;
  int productsTempQuantity;
  int productsMaxQuantity;
  int productsQuantity;
  bool buyStatus;
  int placeorderType;
  int mode;
  int businessStatus;
  int verificationStatus;
  int businessDrawerStatus;
  bool isDeliver;
  bool isCart;
  int productsType;
  int? count = 0;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        kitchenItemId: json["kitchen_item_id"],
        kitchenItemName: json["kitchen_item_name"],
        kitchenItemImage: List<KitchenItemImage>.from(json["kitchen_item_image"]
            .map((x) => KitchenItemImage.fromJson(x))),
        kitchenItemAmount: json["kitchen_item_amount"],
        productsStatus: json["products_status"],
        itemPackagingCharge: json["item_packaging_charge"],
        busaddress: busaddressValues.map[json["busaddress"]]!,
        userId: json["user_id"],
        itemDiscountPrice: json["item_discount_price"],
        productsTempQuantity: json["products_temp_quantity"],
        productsMaxQuantity: json["products_max_quantity"],
        productsQuantity: json["products_quantity"],
        buyStatus: json["buy_status"],
        placeorderType: json["placeorder_type"],
        mode: json["mode"],
        businessStatus: json["business_status"],
        verificationStatus: json["verification_status"],
        businessDrawerStatus: json["business_drawer_status"],
        isDeliver: json["is_deliver"],
        isCart: json["is_cart"],
        productsType: json["products_type"],
      );

  Map<String, dynamic> toJson() => {
        "kitchen_item_id": kitchenItemId,
        "kitchen_item_name": kitchenItemName,
        "kitchen_item_image":
            List<dynamic>.from(kitchenItemImage.map((x) => x.toJson())),
        "kitchen_item_amount": kitchenItemAmount,
        "products_status": productsStatus,
        "item_packaging_charge": itemPackagingCharge,
        "busaddress": busaddressValues.reverse[busaddress],
        "user_id": userId,
        "item_discount_price": itemDiscountPrice,
        "products_temp_quantity": productsTempQuantity,
        "products_max_quantity": productsMaxQuantity,
        "products_quantity": productsQuantity,
        "buy_status": buyStatus,
        "placeorder_type": placeorderType,
        "mode": mode,
        "business_status": businessStatus,
        "verification_status": verificationStatus,
        "business_drawer_status": businessDrawerStatus,
        "is_deliver": isDeliver,
        "is_cart": isCart,
        "products_type": productsType,
      };
}

enum Busaddress { NEAR_BRIDGE }

final busaddressValues = EnumValues({"Near Bridge": Busaddress.NEAR_BRIDGE});

class KitchenItemImage {
  KitchenItemImage({
    required this.images,
  });

  String images;

  factory KitchenItemImage.fromJson(Map<String, dynamic> json) =>
      KitchenItemImage(
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "images": images,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
