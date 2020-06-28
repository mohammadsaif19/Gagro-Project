import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagro/Api/api.dart';
import 'package:gagro/Login/login.dart';
import 'package:gagro/Profile/profile_model.dart';
import 'package:gagro/Profile/profileupdate.dart';
import 'package:gagro/global/global.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_model.dart';

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

    Map user = json.decode(response.body);
    
    debugPrint('$user');
  }

//  signOut() async {
//    SharedPreferences _preference = await SharedPreferences.getInstance();
//    await _preference.clear();
//    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
//  }

  signOut() async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    await _preference.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  final addressController = TextEditingController();
  final occuptionController = TextEditingController();
  final educationController = TextEditingController();
  final dobController = TextEditingController();
  final upazilaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addressController.text = ADDRESS;
    occuptionController.text = OCCUPTION;
    educationController.text = EDUCATION;
    dobController.text = DOB;
    upazilaController.text = UPAZILA;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.purple,
//        actions: <Widget>[
//          FlatButton.icon(
//            onPressed: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => ProfileUpdate()));
//            },
//            icon: Icon(
//              Icons.edit,
//              color: Colors.white,
//            ),
//            label: Text(
//              "Edit Profile",
//              style: TextStyle(
//                  fontSize: 16,
//                  fontWeight: FontWeight.bold,
//                  color: Colors.white),
//            ),
//          ),
//        ],
//      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              padding: EdgeInsets.only(top: 60, right: 20, left: 20, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/man.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      FlatButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileUpdate()));
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

                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    "Name: $EMAIL",
                    style: TextStyle(fontSize: 20),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    "Email:  $EMAIL",
                    style: TextStyle(fontSize: 18),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    "Phone:  $PHONE",
                    style: TextStyle(fontSize: 18),
                  ),

                  SizedBox(
                    height: 20,
                  ),

//                  TextFormField(
//                    controller: dobController,
//                    decoration: InputDecoration(hintText: "Dob"),
//                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: dobController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[300])),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "Dob"),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: occuptionController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[300])),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "Occuption"),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: educationController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[300])),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "Education"),
                    ),
                  ),

//                  TextFormField(
//                    controller: occuptionController,
//                    decoration: InputDecoration(hintText: " Occuption"),
//                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[300])),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "Address"),
                    ),
                  ),

//                  TextFormField(
//                    controller: educationController,
//                    decoration: InputDecoration(hintText: " Education"),
//                  ),

//                  TextFormField(
//                    controller: addressController,
//                    decoration: InputDecoration(hintText: "Address"),
//                  ),

                  // fetchData();

//                  Padding(
//                    padding:
//                        const EdgeInsets.only(left: 80, right: 80, top: 10),
//                    child: Container(
//                      height: 45,
//                      width: 230,
//                      child: RaisedButton(
//                        onPressed: () {
//                          signOut();
//                        },
//                        color: Colors.deepPurple,
//                        child: Text(
//                          "LogOut",
//                          style: TextStyle(fontSize: 15, color: Colors.white),
//                        ),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                      ),
//                    ),
//                  ),

//              FutureBuilder(
//                  future: fetchData(),
//                  builder: (_, snapshot) {
//                    if (snapshot.hasData) {
//                      Gagro user = snapshot.data;
//                      return Container(
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: [
//                            Container(
//                              width: 150,
//                              height: 150,
//                              decoration: BoxDecoration(
//                                shape: BoxShape.circle,
//                                image: DecorationImage(
//                                    image: AssetImage('assets/images/man.png'),
//                                    fit: BoxFit.fill),
//                              ),
//                            ),
//                            SizedBox(
//                              height: 30,
//                            ),
//                            ListTile(title: Text("Name:  " + USERNAME)),
//                            ListTile(
//                                title: Text(
//                                    "Phone:  " + user.data.dataList.phone)),
//                            ListTile(
//                                title: Text("Education:  " +
//                                    user.data.dataList.education)),
//                            SizedBox(
//                              height: 30,
//                            ),
//
//                            Padding(
//                              padding: const EdgeInsets.all(30.0),
//                              child: Container(
//                                height: 45,
//                                width: 230,
//                                child: RaisedButton(
//                                  onPressed: () {
//                                    signOut();
//                                  },
//                                  color: Colors.deepPurple,
//                                  child: Text(
//                                    "LogOut",
//                                    style: TextStyle(
//                                        fontSize: 15, color: Colors.white),
//                                  ),
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(20),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      );
//                    } else {
//                      return Center(
//                          child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          CircularProgressIndicator(),
//                        ],
//                      ));
//                    }
//                  })
                ],
              )),
        ),
      ),
    );
  }
}
