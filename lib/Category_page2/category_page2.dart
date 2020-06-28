import 'package:flutter/material.dart';
import 'package:gagro/Product_model/category_subcategory.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Page2 extends StatelessWidget {
  Page2(this.child2List);

  List<Child2> child2List;
  var rating = 1.0;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView.builder(
        itemCount: child2List.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isFavorite
                                ? Icon(Icons.favorite,
                                    size: 30, color: Color(0xFFEF7532))
                                : Icon(Icons.favorite_border,
                                    size: 30, color: Color(0xFFEF7532))
                          ])),
                  Image.network(
                    child2List[index].image,
                    height: 130,
                    width: 130,
                  ),
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {},
                      starCount: 5,
                      size: 25.0,
                      rating: rating,
                      isReadOnly: false,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_half,
                      defaultIconData: Icons.star_border,
                      color: Colors.red,
                      borderColor: Colors.red,
                      spacing: 0.0),
                  SizedBox(height: 5.0),
                  Text("${child2List[index].name}",
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 22.0)),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}

//ListTile(
//contentPadding: EdgeInsets.all(6.0),
//title: Text("${child2List[index].name}"),
//leading: Image.network(child2List[index].image),
//);
