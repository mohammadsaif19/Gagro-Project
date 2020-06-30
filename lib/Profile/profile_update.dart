import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gagro/global/global.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final _key = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final upazilaController = TextEditingController();
  final dobController = TextEditingController();
  final occuptionController = TextEditingController();
  final imageController = TextEditingController();
  final educationController = TextEditingController();
  final addressController = TextEditingController();
  DateTime date = DateTime.now();
  Map<String, dynamic> data;
  String pMessage = '';
  bool success = false;
  List<String> genderType = ["Male", "Female"];
  String _currentSelectedValue;

  File image;

  gallery() async {
    // ignore: deprecated_member_use
    var _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = _image;
    });
  }

  bool isLoading = false;
  String gender;

  updateProfile() async {
    final form = _key.currentState;
    if (form.validate()) {
      setState(() {
        isLoading = true;
      });
      form.save();
      update();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  update() async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    String token = _preference.getString('token');

    await http.post(
      "http://uat.gagro.com.bd/api/profile",
      body: {
        "name": nameController.text,
        "email": 'demo1@mail.com',
        "phone": phoneController.text,
        "dob": dobController.text,
        "upazila_id": upazilaController.text,
        "address": addressController.text,
        "occupation": occuptionController.text,
        "gender": '',
        "image": '',
        "education": educationController.text,
      },
      headers: {
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    ).then((value) => {
          print(json.decode(value.body)),
          data = json.decode(value.body),
          success = data['Success'] as bool,
          pMessage = data['message'],
          print(success),
          USERNAME = nameController.text,
          EMAIL = emailController.text,
          PHONE = phoneController.text,
          DOB = dobController.text,
          ADDRESS = addressController.text,
          OCCUPTION = occuptionController.text,
          EDUCATION = educationController.text,
          UPAZILA = upazilaController.text
        });

    // print(value);

    // = data["message"];

    if (success == true) {
      setState(() {
        Fluttertoast.showToast(
            msg: pMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.purple,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context, true);
        print(pMessage);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    nameController.text = USERNAME;
    emailController.text = EMAIL;
    phoneController.text = PHONE;
    dobController.text = DOB;
    occuptionController.text = OCCUPTION;
    educationController.text = EDUCATION;
    addressController.text = ADDRESS;
    upazilaController.text = UPAZILA;
    super.initState();
  }

  //get isEditNote => widget != null;

  @override
  Widget build(BuildContext context) {
    String _formattedate = new DateFormat.yMMMMEEEEd().format(date);
    return Scaffold(
      //      backgroundColor: Colors.cyan[200],
      body: SafeArea(
        child: Form(
          key: _key,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: gallery,
                child: Container(
                  height: 100,
                  width: 100,
                  child: image == null
                      ? Image.network(
                          "https://png.pngtree.com/png-clipart/20190614/original/pngtree-man-vector-icon-png-image_3791374.jpg")
                      : Image.file(image),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please enter Name ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[200])),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300])),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Name"),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please enter Phone ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[200])),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300])),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Phone"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  onTap: () async {
                    DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2021));
                    dobController.text = _formattedate.toString();
                    if (picked != null && picked != date) {
                      setState(() {
                        date = picked;
                      });
                    }
                  },
                  controller: dobController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[200])),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300])),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Dob"),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  controller: occuptionController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[200])),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300])),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Occution"),
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
//              Padding(
//                padding: const EdgeInsets.all(30.0),
//                child: FormField<String>(
//                  builder: (FormFieldState<String> state) {
//                    return InputDecorator(
//                      decoration: InputDecoration(
//                          errorStyle: TextStyle(
//                              color: Colors.redAccent, fontSize: 16.0),
//                          hintText: 'Please select expense',
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(5.0))),
//                      isEmpty: _currentSelectedValue == '',
//                      child: DropdownButtonHideUnderline(
//                        child: DropdownButton<String>(
//                          hint: Text("Select a Gender.."),
//                          value: _currentSelectedValue,
//                          isDense: true,
//                          onChanged: (String newValue) {
//                            setState(() {
//                              _currentSelectedValue = newValue;
//                              state.didChange(newValue);
//                            });
//                          },
//                          items: genderType.map((String value) {
//                            return DropdownMenuItem<String>(
//                              value: value,
//                              child: Text(value),
//                            );
//                          }).toList(),
//                        ),
//                      ),
//                    );
//                  },
//                ),
//              ),
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
                      hintText: "Education"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  controller: addressController,
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
                padding: const EdgeInsets.only(left: 90, right: 90, bottom: 30),
                child: Container(
                  height: 45,
                  width: 230,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.purple),
                          ),
                        )
                      : RaisedButton(
                          onPressed: () {
                            updateProfile();
                          },
                          color: Colors.deepPurple,
                          child: Text(
                            "Update",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
