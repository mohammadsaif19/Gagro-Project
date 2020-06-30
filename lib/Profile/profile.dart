import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagro/Api/api.dart';
import 'package:gagro/global/global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_update.dart';

class ProfileGet extends StatefulWidget {
  @override
  _ProfileGetState createState() => _ProfileGetState();
}

class _ProfileGetState extends State<ProfileGet> {
  Future fetchData() async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    String token = _preference.getString('token');
    debugPrint('token is: $token');
    final response = await http.get(BaseURL.profileUpdate,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

    Map userdecode = json.decode(response.body);
    if (userdecode["Success"]) {
      Map user = userdecode["data"]["data_list"];
      addressController.text = user["address"];
      occuptionController.text = user["occupation"];
      educationController.text = user["education"];
      dobController.text = user["dob"];
      upazilaController.text = user["upazila"];
      setState(() {
        USERNAME = user["name"];
        EMAIL = user["email"];
        PHONE = user["phone"];
        ADDRESS = user["address"];
        OCCUPTION = user["occupation"];
        EDUCATION = user["education"];
        DOB = user["dob"];
        UPAZILA = user["upazila"];
      });
    }
    //var p = user["name"];
    // debugPrint('$user');
  }

  final addressController = TextEditingController();
  final occuptionController = TextEditingController();
  final educationController = TextEditingController();
  final dobController = TextEditingController();
  final upazilaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              bool update = false;
              update = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileUpdate()));
              if (update) {
                fetchData();
              }
            },
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            label: Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Card(
                elevation: 1,
                child: Container(
                  height: 250,
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            print("Abir");
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "https://png.pngtree.com/png-clipart/20190614/original/pngtree-man-vector-icon-png-image_3791374.jpg"),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Name: $USERNAME",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        "Name: $PHONE",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(
                controller: educationController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Upazila_Id"),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(
                controller: educationController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Address"),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(
                controller: educationController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Occuption"),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: TextFormField(
                controller: educationController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Education"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
