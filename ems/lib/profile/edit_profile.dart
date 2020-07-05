import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ems/loginscreen/login.dart';
import 'package:ems/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var logOutButtonVisiblity = true;
  var updateOutButtonVisiblity = false;
  bool _openAlert = false;
  var _editIconVisiblity = true;
  String _name, _email, _designation, _department, _image, _empId;
  String _imageUrl;
  TextStyle _labelStyle;
  TextStyle _textStyle = TextStyle(
    color: const Color(0xffc1c1c1),
  );
  bool _isLoading = false;
  SizedBox _sizedBox5 = SizedBox(height: 5.0);
  SizedBox _sizedBox10 = SizedBox(height: 10.0);
  TextEditingController _contact = TextEditingController();
  File _fileImage;
  bool _file = false;
  bool _network = true;
  var key = GlobalKey<ScaffoldState>();
  bool _textField = false;
  SharedPreferences _shared;
  Widget logOutButton() {
    return Container(
      height: 50.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text("Log Out"),
        onPressed: () {},
      ),
    );
  }

  Widget updateButton() {
    return Container(
      height: 50.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text("Update"),
        onPressed: () {},
      ),
    );
  }

  editIconClick() {
    logOutButtonVisiblity == true
        ? logOutButtonVisiblity = false
        : logOutButtonVisiblity = true;

    updateOutButtonVisiblity == false
        ? updateOutButtonVisiblity = true
        : updateOutButtonVisiblity = false;

    _editIconVisiblity == true
        ? _editIconVisiblity = false
        : _editIconVisiblity = true;
    _openAlert == true ? _openAlert = false : _openAlert = true;
    _textField = true;
    setState(() {});
  }

  @override
  void initState() {
    getShared();

    super.initState();
  }

  void getShared() async {
    _shared = await SharedPreferences.getInstance();
    setState(() {
      _email = _shared.getString("email");
      _name = _shared.getString("fname");
      Provider.of<UserProvider>(context, listen: false).setImage =
          _shared.getString("image");
      _designation = _shared.getString("designation");
      _department = _shared.getString("department");
      _contact.text = _shared.getString("contact");
      _empId = _shared.getString("employee_id");
      _image = _shared.getString("image");
    });
  }

  void setShared(String image, String contact) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    setState(() {
      _shared.setString("image", image);
      _shared.setString("contact", contact);
    });
  }

  Widget _text(String text, TextStyle style) {
    return Text(
      text,
      style: style,
    );
  }

  Future _openDialog(BuildContext context) {
    return showDialog(
        context: context,
        child: Dialog(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              GestureDetector(
                onTap: () => _pickImage(ImageSource.camera),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.camera_alt,
                    size: 70.0,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _pickImage(ImageSource.gallery),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.image,
                    size: 70.0,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future _pickImage(ImageSource imageSource) async {
    final File image = await ImagePicker.pickImage(
      source: imageSource,
    );
    if (image != null) {
      setState(() {
        _file = true;
        _fileImage = image;
        _network = false;
        Navigator.pop(context);
      });
    }
  }

  Future<void> logOut(BuildContext context) {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: const Text("LOGOUT"),
        content: const Text("Are You Sure"),
        actions: <Widget>[
          FlatButton(
            child: const Text("No"),
            onPressed: () => no(context),
          ),
          FlatButton(
            child: const Text("Yes"),
            onPressed: () => yes(),
          ),
        ],
      ),
    );
  }

  void yes() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    _shared.setBool("islogin", false);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }

  void no(BuildContext context) {
    Navigator.pop(context);
  }

  void update(UserProvider userProvider, BuildContext context) async {
    if (_contact.text == null) {
      _showSnackBar("Please Enter Contact", Colors.red);
    } else if (_contact.text.trim().length == 0) {
      _showSnackBar("Please Enter Contact", Colors.red);
    } else {
      try {
        setState(() {
          _isLoading = true;
        });
        if (_fileImage == null) {
          var response = await userProvider.updateUser(_empId, _contact.text);
          if ((response["status"])) {
            _file = false;
            _network = true;
            _textField = false;
            setShared(_image, response["post"]["contact"]);
            getShared();
            _showSnackBar("Profile Updated Successfully", Colors.green);
            setState(() {
              _isLoading = false;
              updateOutButtonVisiblity = false;
              logOutButtonVisiblity = true;
              _editIconVisiblity = true;
              _openAlert = false;
            });
          } else {
            setState(() {
              _isLoading = false;
              updateOutButtonVisiblity = false;
              logOutButtonVisiblity = true;
              _editIconVisiblity = true;
              _openAlert = false;
            });
            _showSnackBar("Something Went Wrong", Colors.red);
          }
        } else {
          var response =
              await userProvider.updateUser(_empId, _contact.text, _fileImage);
          if ((response["status"])) {
            _file = false;
            _network = true;
            _textField = false;
            setShared(response["post"]["image"], response["post"]["contact"]);
            getShared();
            _showSnackBar("Profile Updated Successfully", Colors.green);
            setState(() {
              _isLoading = false;
              updateOutButtonVisiblity = false;
              logOutButtonVisiblity = true;
              _editIconVisiblity = true;
              _openAlert = false;
            });
          } else {
            setState(() {
              _isLoading = false;
              updateOutButtonVisiblity = false;
              logOutButtonVisiblity = true;
              _editIconVisiblity = true;
              _openAlert = false;
            });
            _showSnackBar("Something Went Wrong", Colors.red);
          }
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void _showSnackBar(String message, Color color) {
    key.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: color,
      duration: Duration(
        seconds: 2,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _labelStyle = TextStyle(
      color: Theme.of(context).appBarTheme.color,
      fontWeight: FontWeight.bold,
      fontSize: 15.0,
    );
    var provider = Provider.of<UserProvider>(context, listen: false);
    var image = Provider.of<UserProvider>(context).getImage;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).appBarTheme.color,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      key: key,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Visibility(
                    visible: _network,
                    child: Hero(
                      tag: "image",
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        height: 300.0,
                        width: double.infinity,
                        placeholder: (ctx, _) => SpinKitCircle(
                          color: Theme.of(context).appBarTheme.color,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _file,
                    child: _fileImage == null
                        ? Container()
                        : Image.file(
                            _fileImage,
                            height: 300.0,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 30.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _text("Email", _labelStyle),
                        _sizedBox10,
                        _text(_email ?? "", _textStyle),
                        _sizedBox5,
                        TextField(
                          controller: _contact,
                          enabled: _textField,
                          style: TextStyle(
                            color: Color(0xffc1c1c1),
                          ),
                          decoration: InputDecoration(
                              border: _textField ? null : InputBorder.none,
                              labelText: "Contact",
                              labelStyle: TextStyle(
                                color: Theme.of(context).appBarTheme.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              )),
                        ),
                        _sizedBox5,
                        _text("Designation", _labelStyle),
                        _sizedBox5,
                        _text(_designation ?? "", _textStyle),
                        _sizedBox10,
                        _text("Department", _labelStyle),
                        _sizedBox5,
                        _text(_department ?? "", _textStyle),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 270.0, left: 30.0),
                child: Text(
                  _name ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Visibility(
                visible: _editIconVisiblity,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 275.0,
                    left: MediaQuery.of(context).size.width * 0.85,
                  ),
                  child: FloatingActionButton(
                    mini: true,
                    child: Icon(
                      Icons.edit,
                      size: 15.0,
                    ),
                    onPressed: () => editIconClick(),
                    backgroundColor: Theme.of(context).appBarTheme.color,
                    elevation: 10.0,
                  ),
                ),
              ),
              Visibility(
                visible: _openAlert,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 275.0,
                    left: MediaQuery.of(context).size.width * 0.85,
                  ),
                  child: FloatingActionButton(
                    mini: true,
                    child: Icon(
                      Icons.camera_alt,
                      size: 15.0,
                    ),
                    onPressed: () => _openDialog(context),
                    backgroundColor: Theme.of(context).appBarTheme.color,
                    elevation: 10.0,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
            visible: updateOutButtonVisiblity,
            child: Container(
              width: double.infinity,
              height: 50.0,
              child: RaisedButton(
                color: Theme.of(context).appBarTheme.color,
                onPressed: () => update(provider, context),
                textColor: Colors.white,
                child: _isLoading
                    ? SpinKitCircle(
                        color: Colors.white,
                      )
                    : Text(
                        "Update",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
              ),
            ),
          ),
          Visibility(
            visible: logOutButtonVisiblity,
            child: Container(
              width: double.infinity,
              height: 50.0,
              child: RaisedButton(
                color: Colors.orange,
                onPressed: () => logOut(context),
                textColor: Colors.white,
                child: Text(
                  "LOGOUT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
