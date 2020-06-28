import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gagro/Api/api.dart';
import 'package:gagro/Validation_pass/validation_passord.dart';
import 'package:http/http.dart' as http;

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  String email;
  var _key = GlobalKey<FormState>();
  final resetController = TextEditingController();
  bool isLoading = false;

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

  checkForgot() {
    final form = _key.currentState;
    if (form.validate()) {
      setState(() {
        isLoading = true;
      });
      form.save();
      submitForgotten();
    }
  }

  submitForgotten() async {
    final response = await http.post(
      BaseURL.requestResetPassword,
      body: {
        "email": email,
      },
    );

    final data = jsonDecode(response.body);

    bool success = data["Success"];
    String message = data["message"];

    if (success == true) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ValidationPassWord()));
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
        padding: EdgeInsets.all(20),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Reset Password",
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: resetController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter phone";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  onSaved: (e) => email = e,
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
                      hintText: " Phone"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.purple),
                      ),
                    )
                  : RaisedButton(
                      child: Text(
                        "Send Password Reset Link",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      color: Colors.purple,
                      onPressed: () {
                        checkForgot();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
