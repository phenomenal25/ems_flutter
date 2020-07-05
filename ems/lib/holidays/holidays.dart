import 'package:ems/provider/document_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors.dart';

class Holiday extends StatefulWidget {
  @override
  _HolidayState createState() => _HolidayState();
}

class _HolidayState extends State<Holiday> {
  @override
  void initState() {
    fetch();
    super.initState();
  }

  fetch() async {
    await Provider.of<DocumentProvider>(context, listen: false).fetchHolidays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundcolor,
        appBar: AppBar(
          backgroundColor: AppColor.appbarcolor,
          title: const Text("Holiday"),
          centerTitle: true,
        ),
        body: Consumer<DocumentProvider>(builder: (context, model, _) {
          var holidayData = model.getHolidays;
          if (holidayData == null) {
            return Center(
              child: SpinKitCircle(
                color: Theme.of(context).appBarTheme.color,
              ),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: holidayData.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          DateFormat("dd")
                              .format(DateTime.parse(holidayData[index].date)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(DateFormat("MMMM")
                          .format(DateTime.parse(holidayData[index].date))),
                      subtitle: Text(
                        holidayData[index].holidayTitle,
                        style: TextStyle(color: AppColor.appbarcolor),
                      ),
                    ),
                  );
                });
          }
        }));
  }
}
