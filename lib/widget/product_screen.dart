import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gagro/Constent/constant.dart';
import 'package:gagro/Product_List/product_list_model.dart';
import 'package:gagro/screens/product_details.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text(
          'Deals of Week',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 30,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      "20 Products found",
                      style: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.filter_list,
                        color: Colors.black87,
                        size: 20,
                      ),
                      onPressed: null),
                  IconButton(
                      icon: Icon(
                        Icons.format_align_left,
                        color: Colors.black87,
                        size: 20,
                      ),
                      onPressed: null)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: _productScreenTile(),
            )
          ],
        ),
      ),
    );
  }

  Widget _productScreenTile() {
    return FutureBuilder(
      future: fetchGagro(),
      builder: (BuildContext context, AsyncSnapshot<Catalog> snapshot) {
        if (snapshot.hasData) {
          final dataList = snapshot.data.data.dataList;
          return Container(
            height: 240,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
                childAspectRatio: 0.8,
              ),
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                    productObject: dataList[index],
                                  )));
                      debugPrint('$dataList[index]');
                    },
                    child: Container(
                      height: 220,
                      width: 190,
                      decoration: BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(1, 1),
                              blurRadius: 4),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: CachedNetworkImage(
                                    imageUrl: dataList[index].image1,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.radio_button_checked,
                                        size: 20,
                                        color: Colors.greenAccent,
                                      ),
                                      Text(
                                        dataList[index].quantity.toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${dataList[index].name}",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300],
                                          offset: Offset(1, 1),
                                          blurRadius: 4),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.favorite_border,
                                      size: 20,
                                      color: red,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "4.7",
                                      style:
                                          TextStyle(fontSize: 18, color: grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: red,
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: red,
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: red,
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: red,
                                    size: 16,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "${dataList[index].originalPrice}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          print(snapshot.error);
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.purple),
            ),
          );
        }
      },
    );
  }
}

Future<Catalog> fetchGagro() async {
  final response = await http.get(
      'http://uat.gagro.com.bd/api/product-data'); // ?fbclid=IwAR1vj83qPGT3nu-fT8OFT5CU5N3pZOWspDVSrRvU7Q2H-pRB6oIHP2bWkOk

  if (response.statusCode == 200) {
    return Catalog.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
