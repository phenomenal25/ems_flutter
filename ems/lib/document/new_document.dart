import 'dart:convert';

import 'package:ems/model/document_type.dart';
import 'package:ems/provider/document_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewDocument extends StatefulWidget {
  @override
  _NewDocumentState createState() => _NewDocumentState();
}

class _NewDocumentState extends State<NewDocument> {
  final _url = "https://intern.fmv.cc/EmployeeAdmin/employee-documenttype";
  List<DocumentTypeData> _list;
  DocumentTypeData _documentTypeData;
  String _id;
  String _empId;
  bool _isLoad = false;
  final _key = GlobalKey<ScaffoldState>();

  Future<void> _fetchType() async {
    final response = await http.get(_url);
    final decode = json.decode(response.body);
    DocumentType documentType = DocumentType.fromJson(decode);
    _list = documentType.data;
    setState(() {});
  }

  void getSharedPreferences() async {
    final _sharedPeferences = await SharedPreferences.getInstance();
    setState(() {
      _empId = _sharedPeferences.getString("employee_id");
    });
  }

  @override
  void initState() {
    _fetchType();
    getSharedPreferences();
    super.initState();
  }

  void _insert(DocumentProvider documentProvider) async {
    if (_id == null) {
      showToast("Please Select Type", Colors.red);
    } else {
      setState(() {
        _isLoad = true;
      });
      bool status = await documentProvider.insertNewDocument(_empId, _id);
      if (status) {
        setState(() {
          _isLoad = false;
        });
        showToast("document request succefully", Colors.green);
      } else {
        setState(() {
          _isLoad = false;
        });
        showToast("something went wrong", Colors.red);
      }
    }
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

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DocumentProvider>(context, listen: false);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text("New Document Request"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _list == null
              ? SpinKitThreeBounce(color: Theme.of(context).appBarTheme.color)
              : Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<DocumentTypeData>(
                    isExpanded: true,
                    value: _documentTypeData,
                    hint: Text("Select Document"),
                    onChanged: (DocumentTypeData datas) {
                      setState(() {
                        _id = datas.documentTypeId;
                        _documentTypeData = datas;
                      });
                    },
                    items: _list.map((complain) {
                      return DropdownMenuItem<DocumentTypeData>(
                        child: Text(complain.documentType),
                        value: complain,
                      );
                    }).toList(),
                  ),
                ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
              onPressed: () => _insert(provider),
              child: _isLoad
                  ? SpinKitThreeBounce(
                      color: Colors.white,
                    )
                  : Text(
                      "Send",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
