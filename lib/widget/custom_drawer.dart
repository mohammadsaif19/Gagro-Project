import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gagro/global/global.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange),
              accountName: Text(
                "$USERNAME",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w600),
              ),
              currentAccountPicture: Container(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl:
                        'http://uat.gagro.com.bd/gagro/img/logo/logo01.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              accountEmail: Text("demo@mail.com")),

          ExpansionTile(
            title: Text('Category'),
            leading: Icon(Icons.category),
            children: [
              ListTile(
                title: Text('Vegetables'),
                leading: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/b");
                },
              ),
              ListTile(
                title: Text('Fish'),
                leading: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/b");
                },
              ),
              ListTile(
                title: Text('Fruits'),
                leading: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/b");
                },
              ),
            ],
          ), //List Tile 1

          ListTile(
            title: Text('Super Markets'),
            leading: Icon(Icons.store),
          ), //List Tile 3
          ListTile(
            title: Text('Fresh Fruits'),
            leading: Icon(Icons.fiber_smart_record),
          ), //List 4
          ListTile(
            title: Text('Offer Zone'),
            leading: Icon(Icons.local_offer),
          ),
          Divider(
            color: Colors.deepOrange,
            height: 5,
          ), //List Tile 5
          ListTile(
            title: Text('My Cart'),
            leading: Icon(Icons.shopping_cart),
          ), //List Tile 6
          ListTile(
            title: Text('My Wishlist'),
            leading: Icon(Icons.favorite),
          ), //List Tile 7
          ListTile(
            title: Text('My Orders'),
            leading: Icon(Icons.account_balance_wallet),
          ), //List Tile 8
          ListTile(
            title: Text('My Account'),
            leading: Icon(Icons.account_box),
          ),
          Divider(
            color: Colors.deepOrange,
          ),

          ///List Tile 9
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.remove_circle_outline),
          ),
          ListTile(
            title: Text('About us'),
            leading: Icon(Icons.info),
          ), //List Tile 10
        ],
        padding: EdgeInsets.zero,
      ),
    );
  }
}
