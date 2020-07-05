import 'dart:convert';

import 'package:ems/colors.dart';
import 'package:ems/model/complain_type.dart';
import 'package:ems/provider/complain_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NewComplain extends StatefulWidget {
  @override
  _NewComplainState createState() => _NewComplainState();
}

class _NewComplainState extends State<NewComplain> {
  ComplainTypeData _complainData;
  List<ComplainTypeData> _listComplainType;
  String _id;
  String _empId;
  bool _isLoad = false;
  String desc = "";
  final _descController = TextEditingController();
  final _complainType =
      "https://intern.fmv.cc/EmployeeAdmin/employee-complaintype";
  final _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    getSharedPreferences();
    fetchComplainType();
    super.initState();
  }

  void getSharedPreferences() async {
    SharedPreferences _sharedPeferences = await SharedPreferences.getInstance();
    setState(() {
      _empId = _sharedPeferences.getString("employee_id");
    });
  }

  void showToast(String msg, Color color) {
    _key.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              msg,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: color,
        // behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _insertComplain(ComplainProvider provider) async {
    setState(() {
      desc = _descController.text;
    });
    if (_id == null) {
      showToast("Please Select Complain Type", Colors.red);
    } else if (desc.isEmpty || desc.trim().length == 0) {
      showToast("Enter Complain", Colors.red);
    } else {
      setState(() {
        _isLoad = true;
      });
      try {
        final status = await provider.insertNewComplain(_empId, _id, desc);
        print(status);
        if (status) {
          setState(() {
            _isLoad = false;
          });
          showToast("complain inserted succefully", Colors.green);
        } else {
          setState(() {
            _isLoad = false;
          });
          showToast("something went wrong", Colors.red);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> fetchComplainType() async {
    try {
      final response = await http.post(_complainType);
      final descode = json.decode(response.body);
      final complainType = ComplainType.fromJson(descode);
      _listComplainType = complainType.data;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ComplainProvider>(context, listen: false);
    return Scaffold(
      key: _key,
      backgroundColor: AppColor.backgroundcolor,
      appBar: AppBar(
        title: const Text("New Complain"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                  top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
              padding: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: _listComplainType == null
                  ? SpinKitThreeBounce(
                      color: Theme.of(context).appBarTheme.color,
                    )
                  : DropdownButton<ComplainTypeData>(
                      isExpanded: true,
                      value: _complainData,
                      hint: const Text("Select Complain"),
                      onChanged: (ComplainTypeData datas) {
                        setState(() {
                          _id = datas.complainTypeId;
                          _complainData = datas;
                        });
                      },
                      items: _listComplainType.map((complain) {
                        return DropdownMenuItem<ComplainTypeData>(
                          child: Text(complain.complainType),
                          value: complain,
                        );
                      }).toList(),
                    ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _descController,
                maxLines: 3,
                decoration: InputDecoration(
                    hintText: "Complain", border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: double.infinity,
              height: 50.0,
              child: RaisedButton(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Theme.of(context).appBarTheme.color,
                onPressed: () => _insertComplain(provider),
                child: _isLoad
                    ? SpinKitThreeBounce(
                        color: Colors.white,
                      )
                    : const Text(
                        "Approved",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
