import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/leave_type.dart';
import '../provider/leave_provider.dart';
import '../leave/user_detail_leave.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateNewLeave extends StatefulWidget {
  @override
  _CreateNewLeaveState createState() => _CreateNewLeaveState();
}

class _CreateNewLeaveState extends State<CreateNewLeave> {
  LeaveType leaveTypes;
  LeaveTypeData _data;
  bool isLoad = false;
  var _descriptionControoller = TextEditingController();
  String desc = "";
  var _empId = "", image = "";
  String _leavetypeid = "";
  String fromDate = "", toDate = "";
  DateTime fromdate;
  DateTime todate;
  var _imageUrl = "https://intern.fmv.cc/EmployeeAdmin//assets/uploads/";
  final _leavetype = "https://intern.fmv.cc/EmployeeAdmin/employee-leavetype";
  List<LeaveTypeData> _list;
  String name, designation;
  final _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _getSharedPreferences();
    fetchLeaveType();
    super.initState();
  }

  void _getSharedPreferences() async {
    SharedPreferences _sharedPeferences = await SharedPreferences.getInstance();
    setState(() {
      _empId = _sharedPeferences.getString("employee_id");
      _imageUrl += _sharedPeferences.getString("image");
      name = _sharedPeferences.getString("fname");
      designation = _sharedPeferences.getString("designation");
    });
  }

  Future<void> fetchLeaveType() async {
    try {
      var response = await http.post(_leavetype);
      var descode = json.decode(response.body);
      LeaveType leaveType = LeaveType.fromJson(descode);
      _list = leaveType.data;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void fromSelect() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2100),
    ).then((from) {
      if (from != null)
        setState(() {
          fromdate = from;
          fromDate = DateFormat("MMM dd,yyyy").format(from).toString();
        });
    });
  }

  void insertLeave(LeaveProvider leaveProvider) async {
    setState(() {
      desc = _descriptionControoller.text.toString();
    });
    if (fromDate.isEmpty) {
      showToast("please select from date", Colors.red);
    } else if (toDate.isEmpty) {
      showToast("please select to date", Colors.red);
    } else if (_leavetypeid.isEmpty) {
      showToast("please select leave", Colors.red);
    } else if (fromdate.isAfter(todate)) {
      showToast("please select valid date", Colors.red);
    } else if (desc.isEmpty || desc.trim().length == 0) {
      showToast("enter the reason", Colors.red);
    } else {
      setState(() {
        isLoad = true;
      });
      bool status = await leaveProvider.insertNewLeave(
          _empId, _leavetypeid, _descriptionControoller.text, fromDate, toDate);
      if (status) {
        setState(() {
          isLoad = false;
        });
        showToast("leave inserted succefully", Colors.green);
      } else {
        setState(() {
          isLoad = false;
        });
        showToast("something went wrong", Colors.red);
      }
    }
  }

  void toSelect() {
    if (fromDate.isEmpty) {
      showToast("please select from date", Colors.red);
    } else {
      showDatePicker(
        context: context,
        initialDate: fromdate.add(Duration(days: 0)),
        firstDate: fromdate,
        lastDate: DateTime(2100),
      ).then((to) {
        if (to != null)
          setState(() {
            todate = to;
            toDate = DateFormat("MMM dd,yyyy").format(to).toString();
          });
      });
    }
  }

  void showToast(String msg, Color color) {
    _key.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _selectDate(String s, String day, Function function) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: function,
                child: Icon(
                  Icons.date_range,
                  size: 30.0,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    Text(
                      s,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      day,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LeaveProvider newLeave = Provider.of<LeaveProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave Request"),
        elevation: 2.0,
      ),
      key: _key,
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UserDetail(
                image: _imageUrl,
                username: name,
                id: _empId,
                designation: designation,
              ),
              Divider(),
              Container(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Leave Request Info",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900),
                    ),
                    Row(
                      children: <Widget>[
                        _selectDate("From", fromDate, fromSelect),
                        _selectDate("To", toDate, toSelect),
                      ],
                    )
                  ],
                ),
              ),
              Divider(),
              Container(
                margin: const EdgeInsets.only(top: 10.0, left: 20.0),
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.person, size: 30.0),
                    const SizedBox(width: 5.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text("Leave Type"),
                        _list == null
                            ? SpinKitThreeBounce(
                                color: Theme.of(context).appBarTheme.color,
                              )
                            : DropdownButton<LeaveTypeData>(
                                hint: const Text("select leave"),
                                value: _data,
                                onChanged: (LeaveTypeData datas) {
                                  setState(() {
                                    _data = datas;
                                    _leavetypeid = datas.leaveTypeId;
                                  });
                                },
                                items: _list.map((datas) {
                                  return DropdownMenuItem<LeaveTypeData>(
                                    child: Text(datas.leaveType),
                                    value: datas,
                                  );
                                }).toList(),
                              ),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(),
              Container(
                margin: const EdgeInsets.only(
                    top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                child: Row(
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.mode_comment),
                    const SizedBox(width: 5.0),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("Reason"),
                          TextField(
                            controller: _descriptionControoller,
                            maxLines: 3,
                            decoration: const InputDecoration(
                                hintText: "enter your reason"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: double.infinity,
        height: 50.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Theme.of(context).appBarTheme.color,
          onPressed: () => insertLeave(newLeave),
          child: isLoad
              ? const SpinKitThreeBounce(
                  color: Colors.white,
                )
              : const Text(
                  "Approved",
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
