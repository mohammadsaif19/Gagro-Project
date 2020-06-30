import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Product_List/product_list_model.dart';
import '../size_config.dart';

class Des extends StatefulWidget {
  final DataList productObject;

  const Des({Key key, this.productObject}) : super(key: key);
  @override
  _DesState createState() => _DesState();
}

class _DesState extends State<Des> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'HomeScreen App',
              home: Second(
                productObject: widget.productObject,
              ),
            );
          },
        );
      },
    );
  }
}

class Second extends StatefulWidget {
  final DataList productObject;

  Second({Key key, this.productObject}) : super(key: key);
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50 * SizeConfig.heightMultiplier,
                decoration: BoxDecoration(color: Color(0xffC4D4A3)),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                    Spacer(),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              Positioned(
                top: 130.0,
                left: 100.0,
                child: Image.network(
                  widget.productObject.image1,
                  fit: BoxFit.contain,
                  height: 50 * SizeConfig.imageSizeMultiplier,
                  width: 50 * SizeConfig.imageSizeMultiplier,
                ),
              ),
              Positioned(
                top: 45 * SizeConfig.heightMultiplier,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55 * SizeConfig.heightMultiplier,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          widget.productObject.name,
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 2.5 * SizeConfig.textMultiplier,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                        child: Text(
                          "${widget.productObject.description}",
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.bold,
                            fontSize: 1.8 * SizeConfig.textMultiplier,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 30.0),
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: Colors.grey)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 3 * SizeConfig.widthMultiplier,
                                ),
                                Text(
                                  "01",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 3 * SizeConfig.textMultiplier,
                                  ),
                                ),
                                SizedBox(
                                  width: 3 * SizeConfig.widthMultiplier,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: Colors.grey)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5.0),
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              "৳${widget.productObject.originalPrice.toString()}"
                                  .toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 3 * SizeConfig.textMultiplier,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier,
                      ),
                      SizedBox(
                        height: 3 * SizeConfig.heightMultiplier,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3 * SizeConfig.widthMultiplier,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.green),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 1 * SizeConfig.widthMultiplier,
                                      ),
                                      Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              2.5 * SizeConfig.textMultiplier,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
