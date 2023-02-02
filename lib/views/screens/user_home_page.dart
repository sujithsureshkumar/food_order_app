// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order_app/controller/product_controller.dart';
import 'package:food_order_app/views/screens/checkout_screen.dart';
import 'package:food_order_app/views/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

import '../../models/product_category_data_model.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  //ProductCategoryDataModel? productCategoryDataModel;
  late ProductController productController;
  bool isVeg = false;
  bool isNonVeg = true;
  int selectedIndex = 0;
  bool isloading = false;

  // asyncFunction() async {
  //   setState(() {
  //     isloading = true;
  //   });
  //   await getProductData();
  //   setState(() {
  //     isloading = false;
  //   });
  //   //print(productCategoryDataModel!.data[0].products[0].count);
  // }

  @override
  void initState() {
    productController = Provider.of<ProductController>(context, listen: false);
    productController.getProductData();
    //asyncFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          drawer: NavDrawer(),
          backgroundColor: Color(0xFFf8f4ec),
          appBar: AppBar(
            backgroundColor: Color(0xFFf8f4ec),
            iconTheme: IconThemeData(color: Colors.black),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r"[0-9a-zA-Z#\-\.\_@+]+")),
                  ],
                  cursorColor: Colors.white,
                  //controller: searchController,
                  //onChanged: (value) => searchEvent(value),
                  onSubmitted: (value) {},
                  autofocus: false,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search Dish',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 201, 196, 196),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.share,
                  color: Colors.black,
                ),
                tooltip: 'Share icon',
                onPressed: () {},
              ), //IconButton
              //IconButton
            ],
          ),
          bottomNavigationBar: Container(
              color: Color(0xFF0cc49c),
              height: 60,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<ProductController>(
                        builder: (context, productController, _) {
                      return Text(
                        "${productController.totalItems.toString()} items",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    }),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckOutScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "Add to Cart  ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.shopping_cart_outlined)
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: AssetImage('assets/food_item_1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Taza Kitchen",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "From Peyad",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Member Since Aug 16,2021",
                            style: TextStyle(
                              color: Colors.black26,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "FSSAI NO: 2132127004000",
                            style: TextStyle(
                              color: Colors.black26,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Know more",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(30.0),
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Icon(
                                      size: 14,
                                      Icons.person_add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "Follow",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "4.6",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.95,
                    height: 50,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "14",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Posts",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "37",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Followers",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                Icon(Icons.format_list_bulleted),
                                Text("Wall")
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.amberAccent,
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(Icons.restaurant_menu),
                                  Text("Menu")
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                Icon(Icons.videocam_outlined),
                                Text("Video")
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                Icon(Icons.star_border_outlined),
                                Text("Review")
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          SizedBox(
                            width: 60,
                            child: Column(
                              children: [Icon(Icons.chat), Text("Chat")],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      color: Color.fromARGB(255, 230, 205, 196), height: 4),
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Veg",
                            ),
                            Transform.scale(
                              scale: 0.5,
                              child: CupertinoSwitch(
                                value: isVeg,
                                activeColor: Colors.blue,
                                onChanged: (bool value) {
                                  setState(() {
                                    isVeg = value;
                                  });
                                },
                              ),
                            ),
                            Text(
                              "Non Veg",
                            ),
                            Transform.scale(
                              scale: 0.5,
                              child: CupertinoSwitch(
                                value: isNonVeg,
                                activeColor: Colors.blue,
                                onChanged: (bool value) {
                                  setState(() {
                                    isNonVeg = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            //set border radius more than 50% of height and width to make circle
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 0
                                        ? Colors.amber
                                        : null,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                    child: Text("All"),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 1;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 1
                                        ? Colors.amber
                                        : null,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Buy now"),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 2;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 2
                                        ? Colors.amber
                                        : null,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Pre Order"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Consumer<ProductController>(
                      builder: (context, productController, _) {
                    if (productController.isloading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productController
                          .productCategoryDataModel!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExpansionTile(
                            title: Text(
                              productController.productCategoryDataModel!
                                  .data[index].categoryName,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                            children: [
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: productController
                                    .productCategoryDataModel!
                                    .data[index]
                                    .products
                                    .length,
                                itemBuilder: (BuildContext context, int i) {
                                  return categoryItem(
                                      product: productController
                                          .productCategoryDataModel!
                                          .data[index]
                                          .products[i],
                                      size: size);
                                },
                                separatorBuilder:
                                    (BuildContext context, int i) {
                                  return Container(
                                      color: Colors.white, height: 4);
                                },
                              )
                            ]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                            color: Color.fromARGB(255, 230, 205, 196),
                            height: 4);
                      },
                    );
                  }),
                ],
              ),
            ),
          )),
    );
  }

  Container categoryItem({required Product product, required Size size}) {
    double discount = ((product.kitchenItemAmount - product.itemDiscountPrice) /
            product.kitchenItemAmount) *
        100;
    return Container(
      color: Color(0xFFf0ece4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "${discount.toStringAsFixed(0)} % OFF",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      Text(
                        product.kitchenItemName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('(1 min qty)',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black38)),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('₹${product.kitchenItemAmount}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough)),
                      SizedBox(
                        width: 5,
                      ),
                      Text('₹${product.itemDiscountPrice}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(product.kitchenItemImage[0].images),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Color(0xFF0cc49c),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: SizedBox(
                    width: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            if (product.count! > 0) {
                              //  product.count = product.count! - 1;
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
                              // setState(() {
                              //   product.count = product.count! + 1;
                              //   productController.total_items++;
                              //   // print(productController
                              //   //     .productCategoryDataModel!
                              //   //     .data[0]
                              //   //     .products[0]
                              //   //     .count);
                              // });
                              if (product.count! <
                                  product.productsMaxQuantity) {
                                // product.count = product.count! + 1;
                                productController.itemIncreament(product);
                              }
                            },
                            child: Icon(size: 15, Icons.add)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
