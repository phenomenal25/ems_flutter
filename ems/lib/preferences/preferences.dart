import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class Preferences {
  Future<void> setSharedPreferences(Data data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("email", data.email);
    sharedPreferences.setString("fname", data.fname);
    sharedPreferences.setString("contact", data.contact);
    sharedPreferences.setString("employee_id", data.employeeId);
    sharedPreferences.setBool("islogin", true);
    sharedPreferences.setString("image", data.image);
    sharedPreferences.setString("designation", data.designationName);
    sharedPreferences.setString("department", data.departmentName);
  }

  Future<String> getEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get("email");
  }

  Future<String> getFirstname() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get("fname");
  }

  Future<String> getContact() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get("contact");
  }

  Future<String> getEmpId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get("employee_id");
  }

  Future<String> getImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get("image");
  }
}
