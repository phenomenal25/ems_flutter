import 'package:ems/colors.dart';
import 'package:ems/document/new_document.dart';
import 'package:ems/provider/document_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Documents extends StatefulWidget {
  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  String _empId;

  Future<void> getPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _empId = preferences.getString("employee_id");
      try {
        Provider.of<DocumentProvider>(context, listen: false)
            .fetchDocument(_empId);
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Documents"),
          centerTitle: true,
        ),
        backgroundColor: AppColor.backgroundcolor,
        body: Consumer<DocumentProvider>(
          builder: (context, model, _) {
            var data = model.getDocuments;
            if (model.getDocuments == null) {
              return SpinKitThreeBounce(
                color: Theme.of(context).appBarTheme.color,
              );
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, i) {
                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 5.0,
                      child: ListTile(
                        title: Text(data[i].documentType),
                        subtitle: Text(DateFormat("yyyy-dd-MM")
                            .format(DateTime.parse(data[i].date))),
                        trailing: Text(
                          model.checkStatus(data[i].status),
                          style: TextStyle(
                              color: model.statusColor(data[i].status)),
                        ),
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
              builder: (context) => NewDocument(),
            ),
          ),
        ));
  }
}
