import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gagro/Api/api.dart';
import 'package:gagro/Home/home.dart';
import 'package:gagro/Login/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;

  const OtpPage({Key key, this.phoneNumber}) : super(key: key);
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String token;
  bool isLoading = false;

  TextEditingController otp = TextEditingController();
  TextEditingController email = TextEditingController();
  loginWithotp(String otp, String email) async {
    var response = await http.post(BaseURL.userVeri,
        body: {"email": widget.phoneNumber, "code": otp});
    Map user = json.decode(response.body);
    if (user['data']['access_token'] != null) {
      print(user['data']['access_token']);
      _savePreference(user['data']['access_token']);
      Fluttertoast.showToast(
          msg: "Login Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.purple,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      _savePreferencenotVerified();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  _savePreference(String token) async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    setState(() {
      _preference.setString('token', token);
      token = _preference.getString('token');
      debugPrint('toke is: $token');
    });
  }

  _savePreferencenotVerified() async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    await _preference.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (token != null) {
      return HomePage();
    } else {
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter Code";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        controller: otp,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            prefixIcon: Icon(
                              Icons.code,
                              color: Colors.black54,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: "Code"),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 45,
                        width: 150,
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.purple),
                                ),
                              )
                            : RaisedButton(
                                onPressed: () {
                                  loginWithotp(otp.text, email.text);
                                },
                                color: Colors.deepPurple,
                                child: Text(
                                  "Verify",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      );
    }
  }
}
