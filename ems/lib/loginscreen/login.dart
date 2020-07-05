import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../homescreen/homescreen.dart';
import '../preferences/preferences.dart';
import '../provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final sckey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  bool _isPasswordShow = true;

  Preferences _preferences = Preferences();

  Future<void> serverLogin(BuildContext ctx) async {
    if (emailController.text == null ||
        emailController.text.trim().length == 0) {
      showInvalidMessage("Please Enter Email");
    } else if (passwordController.text == null ||
        passwordController.text.trim().length == 0) {
      showInvalidMessage("Please Enter Password");
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        var provider = Provider.of<UserProvider>(ctx, listen: false);
        var _user = await provider.checkLogin(
          emailController.text,
          passwordController.text,
        );

        // print(_user.status);
        // print(_user.data[0].email);
        if (_user.status == true) {
          setState(() {
            _isLoading = false;
          });
          _preferences.setSharedPreferences(_user.data[0]);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          setState(() {
            _isLoading = false;
          });
          showInvalidMessage("Invalid email or password");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void showInvalidMessage(String msg) {
    sckey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              msg,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        // behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      key: sckey,
      backgroundColor: Colors.white,
      body: Container(
        child: Form(
          child: ListView(
            children: <Widget>[
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 70.0, bottom: 20.0),
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).appBarTheme.color,
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/spash_image.jpg"),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.shade100,
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ]),
                ),
              ),
              Container(height: 50.0),
              Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                      color: Colors.purple.shade100,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: const Text(
                          "LOG IN",
                          style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Piedra"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          // hintText: "Email",
                          // filled: true,
                          labelText: "Email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0),
                      child: TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        obscureText: _isPasswordShow,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          // hintText: "Password",
                          // filled: true,
                          labelText: "Password",
                          suffixIcon: InkWell(
                            child: Icon(
                              Icons.remove_red_eye,
                              color: _isPasswordShow
                                  ? Theme.of(context).appBarTheme.color
                                  : Colors.blue,
                            ),
                            onTap: () {
                              setState(() {
                                _isPasswordShow = !_isPasswordShow;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      height: 55.0,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () => serverLogin(context),
                        color: Colors.deepPurpleAccent,
                        child: _isLoading
                            ? SpinKitCircle(color: Colors.white)
                            : const Text(
                                "Log In",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white54,
                                ),
                              ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        // elevation: 3.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
