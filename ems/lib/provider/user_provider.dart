import 'dart:convert';
import 'dart:io';
import '../model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;

class UserProvider with ChangeNotifier {
  User user;
  var md5 = crypto.md5;
  var _url = "https://intern.fmv.cc/EmployeeAdmin/employee-login";
  final _update = "https://intern.fmv.cc/EmployeeAdmin/employee-updateemployee";
  String _image;
  Future<User> checkLogin(String email, String password) async {
    try {
      var response =
          await http.post(_url, body: {"email": email, "password": password});
      print(response.body);
      user = User.fromJson(json.decode(response.body));
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return user;
  }

  // method convert password to hax value
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future updateUser(String empId, String contact, [File image]) async {
    print("calling method");
    var decode;
    try {
      var request;
      var uri = Uri.parse(_update);
      if (image == null) {
        request = http.MultipartRequest('POST', uri)
          ..fields['employee_id'] = empId
          ..fields["contact"] = contact;
      } else {
        request = http.MultipartRequest('POST', uri)
          ..fields['employee_id'] = empId
          ..fields["contact"] = contact
          ..files.add(await http.MultipartFile.fromPath(
            'files',
            image.path,
          ));
        print("yes");
      }
      print(request);
      var response = await http.Response.fromStream(await request.send());
      decode = json.decode(response.body);
      if (response.statusCode == 200) print(response.body);
    } catch (e) {
      print(e);
    }
    return decode;
    // Map data;
    // try {
    //   Dio dio = Dio();
    //   FormData formData = FormData.fromMap({
    //     "files": await MultipartFile.fromFile(image.path,
    //         filename: path.basename(image.path)),
    //     "employee_id": empId,
    //     "contact": contact
    //   });
    //   Response decode = await dio.post(_update,
    //       data: formData, options: Options(contentType: 'multipart/form-data'));
    //   data = decode.data;
    // } catch (e) {
    //   print(e);
    // }
    // return data;
  }

  set setImage(String image) {
    _image = image;
    notifyListeners();
  }

  String get getImage =>
      "https://intern.fmv.cc/EmployeeAdmin//assets/uploads/" + _image;
}
