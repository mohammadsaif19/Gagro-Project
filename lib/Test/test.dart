//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:gagro/Constent/constant.dart';
//
//class ProductListTest extends StatefulWidget {
//  @override
//  _ProductListTestState createState() => _ProductListTestState();
//}
//
//class _ProductListTestState extends State<ProductListTest> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(),
//      body: Column(
//        children: [
//
//
//          Padding(
//            padding: EdgeInsets.all(10),
//            child: Text("Product List"),
//          ),
//
//          Container(
//            height: 240,
//            child: GridView.builder(
//              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                crossAxisCount: 2,
//                crossAxisSpacing: 10.0,
//                mainAxisSpacing: 15.0,
//                childAspectRatio: 0.8,
//              ),
//              itemCount: 2,
//              itemBuilder: (context, index) {
//                return Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Container(
//                    height: 240,
//                    width: 200,
//                    decoration: BoxDecoration(
//                      color: white,
//                      boxShadow: [
//                        BoxShadow(
//                            color: Colors.grey[300],
//                            offset: Offset(1, 1),
//                            blurRadius: 4),
//                      ],
//                    ),
//                    child: Column(
//                      children: [
//                        Image.asset(
//                          "assets/images/man.png",
//                          height: 100,
//                          width: 100,
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: [
//                            Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: Text(
//                                "Food",
//                                style: TextStyle(fontSize: 22),
//                              ),
//                            ),
//                            Padding(
//                              padding: EdgeInsets.all(8),
//                              child: Container(
//                                decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.circular(20),
//                                  color: white,
//                                  boxShadow: [
//                                    BoxShadow(
//                                        color: Colors.grey[300],
//                                        offset: Offset(1, 1),
//                                        blurRadius: 4),
//                                  ],
//                                ),
//                                child: Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Icon(
//                                    Icons.favorite_border,
//                                    size: 20,
//                                    color: red,
//                                  ),
//                                ),
//                              ),
//                            )
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: [
//                            Row(
//                              children: [
//                                Padding(
//                                  padding: const EdgeInsets.only(left: 8.0),
//                                  child: Text(
//                                    "4.7",
//                                    style: TextStyle(fontSize: 18, color: grey),
//                                  ),
//                                ),
//                                SizedBox(
//                                  width: 2,
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: red,
//                                  size: 16,
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: red,
//                                  size: 16,
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: red,
//                                  size: 16,
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: red,
//                                  size: 16,
//                                ),
//                              ],
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(right: 8.0),
//                              child: Text(
//                                "\$122",
//                                style: TextStyle(
//                                    fontSize: 20,
//                                    color: grey,
//                                    fontWeight: FontWeight.bold),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                );
//              },
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}
