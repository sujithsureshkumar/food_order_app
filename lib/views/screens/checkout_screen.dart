// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_order_app/views/screens/user_home_page.dart';
import 'package:provider/provider.dart';

import '../../controller/product_controller.dart';
import '../../models/product_category_data_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late ProductController productController;

  @override
  void initState() {
    productController = Provider.of<ProductController>(context, listen: false);
    productController.productInCart();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFFf8f4ec),
        appBar: AppBar(
          backgroundColor: Color(0xFFf8f4ec),
          leading: const BackButton(
            color: Colors.black,
          ),
          title: Text(
            "My Cart",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            UnconstrainedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      Text(
                        "Clear Cart",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: Consumer<ProductController>(
            builder: (context, productController, _) {
          if (productController.productList.isEmpty) {
            return Center(
              child: Text(
                "No Items in Cart",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: productController.productList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return cartItem(
                                size: size,
                                product: productController.productList[index]);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Bill Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Item Total"),
                              Text("₹ ${productController.itemTotal}"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Taxes & charges"),
                              Text("₹ ${productController.taxAndCharges}"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "GRAND TOTAL",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "₹ ${productController.grandTotal}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      // await _auth.signOut();
                      productController.clearProduct();
                      Fluttertoast.showToast(
                          msg: "Order Successfully Placed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserHomePage()),
                      );
                    },
                    style: TextButton.styleFrom(
                        minimumSize: const Size(300, 50),
                        maximumSize: const Size(300, 50),
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: Text("Place Order")),
              ],
            ),
          );
        }));
  }

  Padding cartItem({required Size size, required Product product}) {
    double totalPrice =
        double.parse((product.itemDiscountPrice * product.count!).toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Chilli Porottadddd"),
                Text("₹ ${product.itemDiscountPrice}"),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                height: 30,
                width: 70,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xFFf8f4ec),
                ),
                child: SizedBox(
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          if (product.count! > 0) {
                            //product.count = product.count! - 1;
                            productController.itemDecreament(product);
                          }
                        },
                        child: Icon(
                          Icons.remove,
                          size: 15,
                        ),
                      ),
                      Text(
                        product.count.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                          onTap: () {
                            if (product.count! < product.productsMaxQuantity) {
                              //product.count = product.count! + 1;
                              productController.itemIncreament(product);
                            }
                          },
                          child: Icon(size: 15, Icons.add)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text("₹ $totalPrice"),
            ],
          ),
        ],
      ),
    );
  }
}
