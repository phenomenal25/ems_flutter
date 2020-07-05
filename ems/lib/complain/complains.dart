import 'package:ems/colors.dart';
import 'package:ems/complain/new_complain.dart';
import 'package:ems/model/complain.dart';
import 'package:ems/provider/complain_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../preferences/preferences.dart';

class Complains extends StatefulWidget {
  @override
  _ComplainsState createState() => _ComplainsState();
}

class _ComplainsState extends State<Complains> {
  Preferences _preferences = Preferences();

  void _getData() async {
    final empId = await _preferences.getEmpId();
    Provider.of<ComplainProvider>(context, listen: false).fetchComplain(empId);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundcolor,
        appBar: AppBar(
          title: const Text("Old Complains"),
          centerTitle: true,
        ),
        body: Consumer<ComplainProvider>(
          builder: (context, model, _) {
            List<ComplainData> data = model.getComplain;
            if (data == null) {
              return Center(
                child: SpinKitThreeBounce(
                  color: Theme.of(context).appBarTheme.color,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: data.reversed.length,
                itemBuilder: (ctx, i) {
                  String date = DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(data[i].date))
                      .toString();
                  return Card(
                    margin: const EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Text(data[i].complainType),
                      subtitle: Text(date),
                    ),
                  );
                },
              );
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
              builder: (context) => NewComplain(),
            ),
          ),
        ));
  }
}
