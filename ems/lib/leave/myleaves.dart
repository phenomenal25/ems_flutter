import 'dart:async';

import 'package:ems/colors.dart';

import '../leave/new_leave.dart';
import '../model/old_leave.dart';
import '../provider/leave_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLeaves extends StatefulWidget {
  @override
  _MyLeavesState createState() => _MyLeavesState();
}

class _MyLeavesState extends State<MyLeaves> {
  var _employeeid;
  var response;
  final _key = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  final _reason = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPreferences();
  }

  Future<void> getPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _employeeid = preferences.getString("employee_id");
      try {
        Provider.of<LeaveProvider>(context, listen: false)
            .fetchLeave(_employeeid);
      } catch (e) {
        print(e);
      }
    });
  }

  Widget showDialogs(BuildContext context, String id) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          color: Color(0xff3E5B7A),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Leave Cancel",
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Center(
          child: const Text("Are you sure to cancel your leave"),
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _reason,
            maxLines: 4,
            decoration: InputDecoration(
                hintText: "Enter Reason",
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder()),
          ),
        ),
        Container(
            constraints: BoxConstraints(
              minWidth: 100.0,
            ),
            margin: EdgeInsets.only(right: 10.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                onPressed: () => _cancelLeave(id),
                color: Colors.teal,
                child: isLoading
                    ? SpinKitPouringHourglass(
                        color: Theme.of(context).appBarTheme.color,
                      )
                    : const Text(
                        "Ok",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ))
      ],
    );
  }

  _cancelLeave(String id) async {
    setState(() {
      isLoading = true;
    });
    final bool status = await Provider.of<LeaveProvider>(context, listen: false)
        .cancelLeave(_employeeid, id, _reason.text);
    if (status) {
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
      _showSnackBar("Cancel Leave Succefully", Colors.green);
    } else {
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
      _showSnackBar("Something Went Wrong", Colors.red);
    }
  }

  void _showSnackBar(String msg, Color color) {
    _key.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundcolor,
        key: _key,
        appBar: AppBar(
          title: const Text("Old Leaves"),
          centerTitle: true,
          backgroundColor: Color(0xff3E5B7A),
          elevation: 0.0,
        ),
        body: Consumer<LeaveProvider>(
          builder: (context, model, _) {
            List<OldLeaveData> data = model.getLeaveList;
            if (model.status == false) {
              return Center(
                child: const Text(
                  "Currently No Leave",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              );
            }
            if (data == null) {
              return Center(
                child: SpinKitThreeBounce(
                  color: Theme.of(context).appBarTheme.color,
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, position) {
                    var from = DateTime.parse(data[position].fromDate);
                    var to = DateTime.parse(data[position].toDate);

                    var totalDays = to.difference(from).inDays + 1;
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: model.statusColor(data[position].status),
                            blurRadius: 1.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 7.0),
                                  child: Text(
                                    data[position].leaveType,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 7.0),
                                  child: Text(
                                    "From:- ${data[position].fromDate}",
                                    maxLines: 1,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 7.0),
                                  child: Text(
                                    "Days:- $totalDays",
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: data[position].status == "1"
                                      ? null
                                      : data[position].status == "2"
                                          ? null
                                          : data[position].status == "3"
                                              ? null
                                              : () => showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext ctx) =>
                                                            Dialog(
                                                      child: showDialogs(
                                                          ctx,
                                                          data[position]
                                                              .leaveId),
                                                    ),
                                                  ),
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  color: Colors.orange,
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    model.checkStatus(data[position].status),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: model.statusColor(
                                        data[position].status,
                                      ),
                                    ),
                                  ),
                                  margin: EdgeInsets.only(top: 7.0),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNewLeave(),
            ),
          ),
        ));
  }
}
