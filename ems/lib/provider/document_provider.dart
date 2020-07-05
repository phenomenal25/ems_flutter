import 'dart:convert';

import 'package:ems/model/document.dart';
import 'package:ems/model/holiday.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DocumentProvider with ChangeNotifier {
  final _documentsUrl =
      "https://intern.fmv.cc/EmployeeAdmin/employee-documentlist";
  final _insert =
      "https://intern.fmv.cc/EmployeeAdmin/employee-documentrequest";
  final _holiday = "https://intern.fmv.cc/EmployeeAdmin/employee-holiday";
  List<DocumentData> _listDocument;
  List<HolidayData> _holidayData;
  Future<void> fetchDocument(String id) async {
    var response = await http.post(_documentsUrl, body: {"id": id});
    var decode = json.decode(response.body);
    Document document = Document.fromJson(decode);
    setComplainList = document.data;
  }

  Future<void> fetchHolidays() async {
    var response = await http.get(_holiday);
    var decode = json.decode(response.body);
    HolidayListModel holidays = HolidayListModel.fromJson(decode);
    setHoliday = holidays.data;
  }

  Future<bool> insertNewDocument(String empId, String complaintypeid) async {
    bool status = false;
    try {
      var body = {
        "employee_id": empId,
        "document_type_id": complaintypeid,
      };
      var response = await http.post(_insert, body: body);
      print(response.body);
      var decode = json.decode(response.body);
      status = decode["status"];
      fetchDocument(empId);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return status;
  }

  set setComplainList(List<DocumentData> data) {
    _listDocument = data;
    notifyListeners();
  }

  List<DocumentData> get getDocuments => _listDocument;
  set setHoliday(List<HolidayData> data) {
    _holidayData = data;
    notifyListeners();
  }

  List<HolidayData> get getHolidays => _holidayData;
  String checkStatus(String data) {
    if (data == "0") {
      return "Pending";
    } else if (data == "1") {
      return "Approve";
    } else if (data == "2") {
      return "Reject";
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
