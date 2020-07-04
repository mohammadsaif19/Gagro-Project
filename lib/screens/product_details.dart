import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gagro/Product_List/product_list_model.dart';
import 'package:gagro/global/global.dart';
import 'package:html/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProductDetailsScreen extends StatefulWidget {
  final DataList productObject;

  const ProductDetailsScreen({Key key, this.productObject}) : super(key: key);
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _addCartClicked = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future addToCart(int productId, int quantity) async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    String token = _preference.getString('token');
    debugPrint("$quantity");
    var response =
        await http.post("http://uat.gagro.com.bd/api/cart", headers: {
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    }, body: {
      "product_id": productId.toString(),
      "quantity": quantity.toString(),
    });

    final addCartdata = json.decode(response.body);
    print(addCartdata);

    bool success = addCartdata["Success"];

    if (success == true) {
      Fluttertoast.showToast(
          msg: "Added product Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "error occoured :(",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  int _counter = 5;

  void _increaseCartItem() {
    setState(() {
      _counter++;
      _addCartClicked = false;
    });
  }

  void _decreaseCartItem() {
    if (_counter <= 5) {
      final snackBar = SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Minimum product order is 5"),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      setState(() {
        _counter--;
      });
    }
  }

  static removeTag({htmlString, callback}) {
    var document = parse(htmlString);
    String parsedString = parse(document.body.text).documentElement.text;
    callback(parsedString);
    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.orange[200],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_shopping_cart,
              color: Colors.black54,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: _detailsScreenTile(),
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: RaisedButton(
          elevation: 0,
          color: _addCartClicked ? Colors.orange : Colors.orange[200],
          shape: OutlineInputBorder(
            borderSide: BorderSide(
              color: _addCartClicked ? Colors.orange : Colors.orange[200],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            if (_addCartClicked != true) {
              addToCart(widget.productObject.id, _counter);
              setState(() {
                _addCartClicked = true;
              });
            }
            return null;
          },
          child: Text(
            _addCartClicked
                ? "Added To Cart".toUpperCase()
                : "Add To Cart".toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _addCartClicked ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailsScreenTile() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            child: Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      )),
                ),
                Positioned(
                  child: DetailsImageSlider(
                    productObject: widget.productObject,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Text(widget.productObject.name,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Text("Each (500g - 700g)",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Text(
                widget.productObject.description == null
                    ? "Description not available for this product"
                    : removeTag(
                        htmlString: widget.productObject.description,
                        callback: (string) => print(string),
                      ),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.black38)),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Text("৳ ${widget.productObject.originalPrice}",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.productObject.price != null
                          ? "৳ ${widget.productObject.price}"
                          : "",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                        decoration: TextDecoration.lineThrough,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _decreaseCartItem(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey)),
                      child: Icon(
                        Icons.remove,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "$_counter",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => _increaseCartItem(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey)),
                      child: Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class DetailsImageSlider extends StatefulWidget {
  final DataList productObject;

  const DetailsImageSlider({Key key, this.productObject}) : super(key: key);
  @override
  _DetailsImageSliderState createState() => _DetailsImageSliderState();
}

class _DetailsImageSliderState extends State<DetailsImageSlider>
    with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 18.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Carousel(
            boxFit: BoxFit.fill,
            images: [
              CachedNetworkImage(imageUrl: widget.productObject.image1),
            ],
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(seconds: 1),
            autoplayDuration: Duration(seconds: 3),
            dotSize: 4.0,
            dotIncreasedColor: Colors.orange[200],
            dotColor: Colors.orange,
            dotSpacing: 10.0,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.transparent,
            borderRadius: true,
            moveIndicatorFromBottom: 180.0,
            noRadiusForIndicator: true,
          )),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
