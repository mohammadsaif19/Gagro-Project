import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gagro/Api/api.dart';
import 'package:gagro/BottomBar/bottom_bar.dart';
import 'package:gagro/Constent/constant.dart';
import 'package:gagro/Login/login.dart';
import 'package:gagro/Product_List/product_list.dart';
import 'package:gagro/Product_model/category_subcategory.dart';
import 'package:gagro/Profile/profile.dart';
import 'package:gagro/category_page1/page1.dart';
import 'package:gagro/widget/custom_drawer.dart';
import 'package:gagro/widget/product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Api/api.dart';

enum PageEnum { profilePage }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _onSelect(PageEnum value) {
    switch (value) {
      case PageEnum.profilePage:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => ProfileGet()));
        break;
      default:
    }
  }

  bool isLoading = false;

  void signOut() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences _preference = await SharedPreferences.getInstance();
    String token = _preference.getString('token');
    debugPrint('token is: $token');
    final response = await http.get(BaseURL.logout).then((value) async {
      await _preference.clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false,
      );
      setState(() {
        isLoading = true;
      });
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.red),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : FlatButton(
                  onPressed: () {
                    signOut();
                  },
                  child: Text(
                    "LogOut",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  )),
          PopupMenuButton<PageEnum>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.deepOrange,
            ),
            onSelected: _onSelect,
            itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
              PopupMenuItem<PageEnum>(
                value: PageEnum.profilePage,
                child: Text("Profile"),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.sentiment_very_satisfied),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
      drawer: CustomDrawer(),
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300],
                      offset: Offset(1, 1),
                      blurRadius: 4),
                ],
              ),
              child: ListTile(
                leading: Icon(
                  Icons.search,
                  color: red,
                ),
                title: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Search  product.."),
                ),
                trailing: Icon(
                  Icons.filter_list,
                  color: red,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 15,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Category",
              style: TextStyle(fontSize: 26),
            ),
          ),
          SizedBox(
            height: 15,
          ),

          Container(
            height: 150,
            child: FutureBuilder(
              future: fetchGagro(),
              builder: (BuildContext context, AsyncSnapshot<Gagro> snapshot) {
                if (snapshot.hasData) {
                  final dataList = snapshot.data.data.dataList;
                  return Container(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300],
                                          offset: Offset(1, 1),
                                          blurRadius: 4),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Page1(
                                                  dataList[index].childList)),
                                        );
                                      },
                                      child: Image.network(
                                        dataList[index].image,
                                        width: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${dataList[index].name}",
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
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
            ),
          ),

          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Product List",
                style: TextStyle(fontSize: 22),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProductScreen()));
                },
                child: Text(
                  "See More",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),

          //  2nd part of widget product list widget,

          ProductList(),
        ],
      ),
    );
  }
}

Future<Gagro> fetchGagro() async {
  final response = await http.get(
      'http://uat.gagro.com.bd/api/category-data'); // ?fbclid=IwAR1vj83qPGT3nu-fT8OFT5CU5N3pZOWspDVSrRvU7Q2H-pRB6oIHP2bWkOk

  try {
    if (response.statusCode == 200) {
      return Gagro.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  } catch (e) {}
}
