import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagro/Api/api.dart';
import 'package:gagro/Profile/profile_update.dart';
import 'package:gagro/global/global.dart';
import 'package:gagro/utils/custom_textStyle.dart';
import 'package:gagro/utils/customer_color.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
              color: Colors.white,
            ),
            label: Text(
              "Edit Profile",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
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
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(colors: [
                                    CustomColors
                                        .EDIT_PROFILE_PIC_FIRST_GRADIENT,
                                    CustomColors
                                        .EDIT_PROFILE_PIC_SECOND_GRADIENT
                                  ])),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 120,
                              height: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(
                                        Icons.image,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {}),
                                  Text(
                                    "Choose Image",
                                    style: CustomTextStyle.textFormFieldMedium
                                        .copyWith(
                                            color: Colors.white, fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
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
                      Text(
                        "Email: $EMAIL",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        "Phone: $PHONE",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: TextFormField(
                controller: dobController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: border,
                  hintText: "Dob",
                  focusedBorder: border.copyWith(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 24),
            ),
            Container(
              child: TextFormField(
                controller: occuptionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: border,
                  hintText: "Occuption",
                  focusedBorder: border.copyWith(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 24),
            ),
            Container(
              child: TextFormField(
                controller: educationController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: border,
                  hintText: "Education",
                  focusedBorder: border.copyWith(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 24),
            ),
            Container(
              child: TextFormField(
                controller: addressController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: border,
                  hintText: "Address",
                  focusedBorder: border.copyWith(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 24),
            ),
          ],
        ),
      ),
    );
  }

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.grey));
}
