import 'package:ems/model/complain.dart';
import 'package:ems/model/complain_type.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ComplainProvider with ChangeNotifier {
  final _insertComplain =
      "https://intern.fmv.cc/EmployeeAdmin/employee-insertcomplain";
  final _complainListUrl =
      "https://intern.fmv.cc/EmployeeAdmin/employee-complainlist";

  List<ComplainData> _listComplain;
  List<ComplainTypeData> _list = [];

  Future<bool> insertNewComplain(
      String empId, String complaintypeid, String desc) async {
    bool status = false;
    try {
      var body = {
        "employee_id": empId,
        "complain_type_id": complaintypeid,
        "description": desc
      };
      var response = await http.post(_insertComplain, body: body);
      print(response.body);
      var decode = json.decode(response.body);
      status = decode["status"];
      fetchComplain(empId.toString());
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return status;
  }

  Future<void> fetchComplain(String id) async {
    try {
      var response = await http.post(_complainListUrl, body: {"id": id});
      var descode = json.decode(response.body);
      Complain complain = Complain.fromJson(descode);
      setComplainList = complain.data;
    } catch (e) {
      print(e);
    }
  }

  set setComplainList(List<ComplainData> data) {
    _listComplain = data;
    notifyListeners();
  }

  set setComplainTypeList(List<ComplainTypeData> data) {
    _list = data;
    notifyListeners();
  }

  List<ComplainData> get getComplain => _listComplain;

  List<ComplainTypeData> get getComplainType => _list;
}
