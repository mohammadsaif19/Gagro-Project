import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gagro/Api/api.dart';
import 'package:gagro/CheckOut/checkout.dart';
import 'package:gagro/utils/custom_textStyle.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    fetchCartItem();
  }

  String productName;
  List cartObject = [];
  Future fetchCartItem() async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    String token = _preference.getString('token');

    debugPrint('token is: $token');
    final response = await http.get(BaseURL.getCart,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    debugPrint("$response");
    debugPrint('cart token is: $token');

    Map cart = json.decode(response.body);

    if (response.statusCode == 200) {
      debugPrint("Response code: ${response.statusCode.toString()}");
      debugPrint("Cart status : $response");
      List cartList = cart["data"]["data_list"];
      setState(() {
        cartObject = cartList;
      });

      //return Cart.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [createCartList(), footer(context)],
        ),
      ),
    );
  }

  footer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: CustomTextStyle.textFormFieldMedium
                      .copyWith(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Text(
                  "\$299.00",
                  style: CustomTextStyle.textFormFieldBlack.copyWith(
                      color: Colors.greenAccent.shade700, fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => CheckOutPage()));
            },
            color: Colors.green,
            padding: EdgeInsets.only(top: 15, left: 60, right: 60, bottom: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Text(
              "Checkout",
              style: CustomTextStyle.textFormFieldSemiBold
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
    );
  }

  createCartList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: cartObject.length,
      itemBuilder: (context, index) {
        return CartPageTile(cartObject: cartObject[index]);
      },
    );
  }
}

class CartPageTile extends StatefulWidget {
  final cartObject;
  CartPageTile({Key key, this.cartObject}) : super(key: key);

  @override
  _CartPageTileState createState() => _CartPageTileState();
}

class _CartPageTileState extends State<CartPageTile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Dismissible(
          key: ValueKey("id"),
          background: Container(
            color: Theme.of(context).errorColor,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          ),
          direction: DismissDirection.endToStart,
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      color: Colors.blue.shade200,
                      image: DecorationImage(
                          image: NetworkImage(widget.cartObject['image']),
                          fit: BoxFit.cover)),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 8, top: 4),
                          child: Text(
                            widget.cartObject['name'],
                            maxLines: 2,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(fontSize: 14),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "৳ ${widget.cartObject['total']}",
                                style: CustomTextStyle.textFormFieldBlack
                                    .copyWith(color: Colors.green),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(
                                      Icons.remove,
                                      size: 24,
                                      color: Colors.grey.shade700,
                                    ),
                                    Container(
                                      color: Colors.grey.shade200,
                                      padding: const EdgeInsets.only(
                                          bottom: 2, right: 12, left: 12),
                                      child: Text(
                                        widget.cartObject['quantity'],
                                        style: CustomTextStyle
                                            .textFormFieldSemiBold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.add,
                                      size: 24,
                                      color: Colors.grey.shade700,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 100,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
