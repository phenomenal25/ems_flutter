import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/leave_type.dart';

import '../model/old_leave.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class LeaveProvider with ChangeNotifier {
  final _url = "https://intern.fmv.cc/EmployeeAdmin/employee-leavelist";

  final _insertLeaveUrl =
      "https://intern.fmv.cc/EmployeeAdmin/employee-insertleave";
  final _cancel = "https://intern.fmv.cc/EmployeeAdmin/employee-cancelleave";

  List<OldLeaveData> _oldLeaveList;
  List<LeaveTypeData> _leaveTypeList;
  bool status;

  Future<void> fetchLeave(String id) async {
    try {
      var response = await http.post(_url, body: {"id": id});
      var descode = json.decode(response.body);
      OldLeave oldLeave = OldLeave.fromJson(descode);
      status = oldLeave.status;
      setLeaveList = oldLeave.data;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> insertNewLeave(String empId, String leaveTypeId, String desc,
      String from, String to) async {
    bool status;
    try {
      var body = {
        "employee_id": empId,
        "leave_type_id": leaveTypeId,
        "description": desc,
        "from_date": from,
        "to_date": to
      };
      var response = await http.post(_insertLeaveUrl, body: body);
      print(response.body);
      var decode = json.decode(response.body);
      status = decode["status"];
      fetchLeave(empId);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return status;
  }

  Future<bool> cancelLeave(String empId, String leaveId, String reason) async {
    bool status;
    try {
      var body = {
        "employee_id": empId,
        "leave_id": leaveId,
        "reason": reason,
        "status": "3",
      };
      var response = await http.post(_cancel, body: body);
      print(response.body);
      var decode = json.decode(response.body);
      status = decode["status"];
      fetchLeave(empId);
    } catch (e) {
      print(e.toString());
    }
    return status;
  }

  set setLeaveList(List<OldLeaveData> data) {
    _oldLeaveList = data;
    notifyListeners();
  }

  set setLeaveTypeList(List<LeaveTypeData> data) {
    _leaveTypeList = data;
    notifyListeners();
  }

  List<OldLeaveData> get getLeaveList => _oldLeaveList;

  List<LeaveTypeData> get getLeaveTypeList => _leaveTypeList;

  String checkStatus(String data) {
    if (data == "0") {
      return "Pending";
    } else if (data == "1") {
      return "Approve";
    } else if (data == "2") {
      return "Reject";
    } else if (data == "3") {
      return "Cancel";
    } else {
      return null;
    }
  }

  Color statusColor(String data) {
    if (data == "0") {
      return Colors.orange;
    } else if (data == "1") {
      return Colors.green;
    } else if (data == "2") {
      return Colors.red;
    } else if (data == "3") {
      return Colors.red;
    } else {
      return null;
    }
  }
}
