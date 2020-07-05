import 'package:ems/homescreen/homescreen.dart';
import 'package:ems/loginscreen/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var status;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      getPreferences();
    });
  }

  getPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      status = preferences.getBool("islogin");
      if (status == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150.0,
          width: 150.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            backgroundColor: const Color(0xffffff),
            backgroundImage: AssetImage('assets/spash_image.jpg'),
          ),
        ),
      ),
    );
  }
}
