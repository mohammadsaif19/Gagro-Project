import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gagro/Api/api.dart';
import 'package:gagro/Constent/constant.dart';
import 'package:gagro/Login/login.dart';
import 'package:gagro/global/global.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final _keySign = GlobalKey<FormState>();
  String selectedAccountType,
      account,
      phoneErrorMsg,
      emailErrorMsg,
      errorMessage = '';
  List accountType = ["Client", "Agent", "Vendor"];
  bool _showPassword = false;
  bool isLoading = false;
  int responseStatusCode = 0;

  void _showDialog(BuildContext context, String message, String title) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK!'),
          )
        ],
      ),
    );
  }

  handleSignUp() async {
    final form = _keySign.currentState;
    if (form.validate()) {
      setState(() {
        isLoading = true;
      });
      form.save();
      register();
    }
  }

  register() async {
    var response;
    var error;
    try {
      response = await http.post(
        BaseURL.register,
        body: {
          "account_type": account, // Drop Down Button
          "name": nameController.text,
          "email": mailController.text,
          "phone": phoneController.text,
          "password": passwordController.text,
          "password_confirmation": confirmPasswordController.text,
        },
        //  headers: {HttpHeaders.contentTypeHeader: "application/json"},
        headers: {"Accept": "application/json"},
      );
      responseStatusCode = response.statusCode;
      print("response code");
      print(responseStatusCode);
      if (responseStatusCode != 200 || responseStatusCode != 201) {
        errorMessage = '';
        phoneErrorMsg = json.decode(response.body)["errors"]["phone"];
        emailErrorMsg = json.decode(response.body)["errors"]["email"];
        errorMessage += phoneErrorMsg != null ? phoneErrorMsg : '';
        if (errorMessage.length > 1) {
          errorMessage += "\n";
        }
        errorMessage += emailErrorMsg != null ? emailErrorMsg : '';
      }
    } catch (_) {
      print("error");
      print(_.error);
    }
    var data = json.decode(response.body);
    print(data);

    bool success = data["Success"];
    String pMessage = data["message"]; // the given data invaild ai message

    if (emailErrorMsg == null && phoneErrorMsg == null) {
      setState(() {
        USERNAME = nameController.text;
        EMAIL = mailController.text;
        PHONE = phoneController.text;

        Fluttertoast.showToast(
            msg: "Registration Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.purple,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()))
            .catchError((error) {});
        setState(() {
          isLoading = false;
        });
        print(pMessage);
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print(pMessage);
      _showDialog(context, errorMessage, "Error");
    }
  }

  @override
  void initState() {
    //getAccountList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Form(
            key: _keySign,
            child: ListView(children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.black54,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Name"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: black),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    elevation: 100,
                    hint: Text("Select Account Type..."),
                    value: selectedAccountType,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        selectedAccountType = newValue;
                      });
                      selectedAccountType == accountType[0]
                          ? account = "7"
                          : selectedAccountType == accountType[1]
                              ? account = "5"
                              : selectedAccountType == accountType[2]
                                  ? account = "4"
                                  : account = "";
                      print(selectedAccountType);
                      print(account);
                    },
                    items: accountType.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: mailController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black54,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Email"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black54,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Phone"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Colors.black54,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Password"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Colors.black54,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Password"),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Container(
                  height: 45,
                  width: 230,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.purple)),
                        )
                      : RaisedButton(
                          onPressed: () {
                            handleSignUp();
                          },
                          color: Colors.deepPurple,
                          child: Text(
                            "SignUp",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  List accountTypeList;

  String accountTypeUrl = 'http://uat.gagro.com.bd/api/get-account-type';

  Future getAccountList() async {
    await http.get(
      accountTypeUrl,
      headers: {"Accept": "application/json"},
    ).then((response) {
      Map<String, dynamic> map = json.decode(response.body);
      print(map);
      Map<String, dynamic> data = map["data"];
      print(data);
      var _data = data["data_list"].toList();
      print(_data);
      setState(() {
        accountTypeList = _data;
      });
    });
  }
}
