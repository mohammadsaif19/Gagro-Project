import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gagro/Api/api.dart';
import 'package:gagro/Home/home.dart';
import 'package:gagro/OtpPage/otp.dart';
import 'package:gagro/Register/register.dart';
import 'package:gagro/ResetRequest/rreset.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn, alreadyLoggedIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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

  bool _showPassword = false;
  bool _rememberMe = false;

  final _key = GlobalKey<FormState>();
  bool isLoading = false;
  String _phoneNumber, _password;

  checkApiLogin() async {
    final form = _key.currentState;
    if (form.validate()) {
      setState(() {
        isLoading = true;
      });
      form.save();
      login();
      //      print("$name  $password");
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  login() async {
    var response = await http.post(
      BaseURL.login,
      body: {"email": _phoneNumber, "password": _password, "remember_me": "1"},
    );

    final data = json.decode(response.body);
    print(data);

    bool success = data["Success"];
    String pMessage = data["message"];

    if (success == true) {
      setState(() {
        _phoneNumberController.clear();
        _passwordController.clear();
        _loginStatus = LoginStatus.signIn;
        _savePreference(success);
      });

      print(pMessage);
    } else {
      setState(() {
        isLoading = false;
      });
      _showMsg(data['message']);
    }
  }

  _savePreference(bool success) async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    setState(() {
      _preference.setBool('isLogin', true);
    });
  }

  bool success;

  signOut() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      _sharedPreferences.setBool("user", false);
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  _checkUserLoggedIn() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    bool _isLogin = _pref.getBool('isLogin');
    debugPrint("login status : $_isLogin");

    if (_isLogin == true) {
      setState(() {
        _loginStatus = LoginStatus.alreadyLoggedIn;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        _loginStatus = LoginStatus.notSignIn;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          key: _scaffoldKey,
          body: Container(
            width: double.infinity,
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage('assets/images/grocery.png'),
//                fit: BoxFit.cover,
//              ),
//            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome To Our Grocery Shop",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Form(
                                key: _key,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Icon(
                                            Icons.phone,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        Text(
                                          "Phone number",
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: _phoneNumberController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter your valid phone number !!";
                                          }
                                          return null;
                                        },
                                        onChanged: (numVal) {
                                          setState(() {
                                            _phoneNumber = numVal.trim();
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText: "i.e: 01xxxxxxxxx",
                                            hintStyle: TextStyle(
                                              color: Colors.black54,
                                            ),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Icon(
                                            Icons.lock_outline,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        Text(
                                          "Password",
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter your valid password !!";
                                          }
                                          return null;
                                        },
                                        onChanged: (passVal) {
                                          setState(() {
                                            _password = passVal.trim();
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText: "*********",
                                            hintStyle: TextStyle(
                                              color: Colors.black54,
                                            ),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Remember me',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPass()));
                                  },
                                  padding: EdgeInsets.only(right: 0.0),
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Container(
                                height: 45,
                                width: 230,
                                child: isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.lightGreen),
                                        ),
                                      )
                                    : RaisedButton(
                                        onPressed: () {
                                          checkApiLogin();
                                        },
                                        color: Colors.greenAccent,
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  " Don\'t have an Account ? ",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                      color: Colors.grey[700]),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  child: Container(
                                    child: Text(
                                      "SignUp",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return OtpPage(
          phoneNumber: _phoneNumber,
        );
        break;
      case LoginStatus.alreadyLoggedIn:
        return HomePage();
        break;
    }
  }
}
