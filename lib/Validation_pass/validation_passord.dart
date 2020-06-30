import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gagro/Api/api.dart';
import 'package:gagro/Home/home.dart';
import 'package:gagro/global/global.dart';
import 'package:http/http.dart' as http;

class ValidationPassWord extends StatefulWidget {
  @override
  _ValidationPassWordState createState() => _ValidationPassWordState();
}

class _ValidationPassWordState extends State<ValidationPassWord> {
  String email, code, password, passwordConfirmation;
  TextEditingController mailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _showPassword = false;
  bool isLoading = false;

  var _key = GlobalKey<FormState>();
  // snackBar Error Show Data
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      setState(() {
        isLoading = true;
      });
      form.save();
      verification();
    }
  }

  verification() async {
    final response = await http.post(
      BaseURL.userValidationPass,
      body: {
        "email": EMAIL,
        "code": code,
        "password": password,
        "password_confirmation": passwordConfirmation,
      },
    );

    final data = jsonDecode(response.body);
    bool success = data["Success"];
    String message = data["message"];

    if (success == true) {
      Fluttertoast.showToast(
          msg: "You are Successfully Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.purple,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      _showMsg(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: codeController,
                keyboardType: TextInputType.number,
                onSaved: (e) => code = e,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    prefixIcon: Icon(
                      Icons.code,
                      color: Colors.black54,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Code"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onSaved: (e) => password = e,
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
                onSaved: (e) => passwordConfirmation = e,
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
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  height: 45,
                  width: 230,
                  child: RaisedButton(
                    onPressed: () {
                      check();
                    },
                    color: Colors.deepPurple,
                    child: Text(
                      "LogOut",
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
