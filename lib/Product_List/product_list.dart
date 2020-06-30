import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gagro/Constent/constant.dart';
import 'package:gagro/Product_List/product_list_model.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
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
                      children: [
                        Image.network(
                          dataList[index].image1,
                          height: 100,
                          width: 100,
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
                      ],
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

  try {} catch (e) {
    if (response.statusCode == 200) {
      return Catalog.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
