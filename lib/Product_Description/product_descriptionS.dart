import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gagro/Product_List/product_list_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final DataList productObject;

  ProductDetailsScreen({Key key, this.productObject}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: Text(widget.productObject.name),
      ),
      bottomNavigationBar: _customBottomBar(),
      body: DetailScreen(
        productObject: widget.productObject,
      ),
    );
  }

  Widget _customBottomBar() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: RaisedButton(
              elevation: 0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  side: BorderSide(color: Color(0xFFfef2f2))),
              onPressed: () {},
              color: Color(0xFFfef2f2),
              textColor: Colors.white,
              child: Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text("Add to Wishlist".toUpperCase(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFff665e))),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: RaisedButton(
              elevation: 0,
              onPressed: () {},
              color: Color(0xFFff665e),
              textColor: Colors.white,
              child: Container(
                padding:
                    EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
                child: Text("Add To Cart".toUpperCase(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFFFFFF))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final DataList productObject;

  DetailScreen({Key key, this.productObject}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: widget.productObject.image1,
              fit: BoxFit.fill,
              height: 200,
              width: 300,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            color: Color(0xFFFFFFFF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("SKU".toUpperCase(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF565656))),
                Text(widget.productObject.sku,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFfd0100))),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF999999),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            color: Color(0xFFFFFFFF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Price".toUpperCase(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF565656))),
                Text("৳ ${widget.productObject.originalPrice}".toUpperCase(),
                    style: TextStyle(
                        color: Color(0xFF0dc2cd),
                        fontFamily: 'Roboto-Light.ttf',
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            color: Color(0xFFFFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Description",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF565656))),
                SizedBox(
                  height: 15,
                ),
                Text("${widget.productObject.description}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4c4c4c))),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            color: Color(0xFFFFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Specification",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF565656))),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // List<Widget> generateProductSpecification(BuildContext context) {
  //   List<Widget> list = [];
  //   int count = 0;
  //   widget.productObject..forEach((specification) {
  //     Widget element = Container(
  //       height: 30,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           Text(specification.specificationName,
  //               textAlign: TextAlign.left,
  //               style: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w400,
  //                   color: Color(0xFF444444))),
  //           Text(specification.specificationValue,
  //               textAlign: TextAlign.left,
  //               style: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w400,
  //                   color: Color(0xFF212121))),
  //         ],
  //       ),
  //     );
  //     list.add(element);
  //     count++;
  //   });
  //   return list;
  // }
}
