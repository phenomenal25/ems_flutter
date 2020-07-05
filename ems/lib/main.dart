import 'package:ems/provider/document_provider.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import './provider/complain_provider.dart';
import './provider/leave_provider.dart';
import './provider/user_provider.dart';
import './splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _isAuthenticated = false;

  void _checkAuthtication() async {
    try {
      bool authenticate = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please Authenticate",
        useErrorDialogs: true,
        stickyAuth: true,
      );
      if (!mounted) return;
      _isAuthenticated = authenticate;
      setState(() {});
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _checkAuthtication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: LeaveProvider()),
        ChangeNotifierProvider.value(value: ComplainProvider()),
        ChangeNotifierProvider.value(value: DocumentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ems',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(
              color: Color(0xff3e5b7a),
            )),
        home: _isAuthenticated
            ? SplashScreen()
            : Scaffold(
                body: Center(
                  child: RaisedButton(
                    child: Text("Try Again"),
                    onPressed: () => _checkAuthtication(),
                  ),
                ),
              ),
      ),
    );
  }
}
