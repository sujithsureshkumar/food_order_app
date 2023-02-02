import 'package:flutter/material.dart';

import '../models/product_category_data_model.dart';
import 'package:http/http.dart' as http;

class ProductController extends ChangeNotifier {
  ProductCategoryDataModel? productCategoryDataModel;
  bool _isloading = false;
  bool get isloading => _isloading;
  int totalItems = 0;
  List<Product> productList = [];
  double itemTotal = 0;
  double taxAndCharges = 57.4;
  double grandTotal = 0;

  clearProduct() {
    totalItems = 0;
    itemTotal = 0;
    taxAndCharges = 0;
    grandTotal = 0;
    productList.clear();
  }

  itemIncreament(Product product) {
    taxAndCharges = 57.4;
    grandTotal = 0;
    product.count = product.count! + 1;

    itemTotal = itemTotal + product.itemDiscountPrice;
    grandTotal = itemTotal + taxAndCharges;
    totalItems++;
    notifyListeners();
  }

  itemDecreament(Product product) {
    grandTotal = 0;
    product.count = product.count! - 1;
    itemTotal = itemTotal - product.itemDiscountPrice;

    grandTotal = itemTotal + taxAndCharges;
    totalItems--;
    if (totalItems == 0) {
      grandTotal = 0;
      taxAndCharges = 0;
    } else {
      grandTotal = itemTotal + taxAndCharges;
    }
    notifyListeners();
  }

  productInCart() {
    if (productCategoryDataModel != null) {
      productList = [];
      for (int i = 0; i < productCategoryDataModel!.data.length; i++) {
        for (int j = 0;
            j < productCategoryDataModel!.data[i].products.length;
            j++) {
          if (productCategoryDataModel!.data[i].products[j].count! > 0) {
            productList.add(productCategoryDataModel!.data[i].products[j]);
          }
        }
      }
    }
    // notifyListeners();
  }

  Future<void> getProductData() async {
    _isloading = true;
    http.Response response = await getProductResponse();
    if (response.statusCode == 200) {
      productCategoryDataModel =
          productCategoryDataModelFromJson(response.body);
    } else {
      print("failed");
    }
    _isloading = false;
    notifyListeners();
  }

  Future<http.Response> getProductResponse() async {
    final response = await http.get(
      Uri.parse(
          "https://www.butomy.com/api/getbusinessbytimeline-petpooja-timing?business_type=1&page_id=351&user_id=367&offset=0&products_type=all&placeorder_type=all"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
        //'Authorization': 'Bearer $token'
      },
    );
    return response;
  }
}
