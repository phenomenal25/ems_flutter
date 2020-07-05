import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Attendence extends StatefulWidget {
  @override
  _AttendenceState createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> {
  var _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendence"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TableCalendar(
              locale: 'en_Us',
              initialCalendarFormat: CalendarFormat.month,
              calendarController: _calendarController,
              calendarStyle: CalendarStyle(
                todayColor: Colors.blue,
                selectedColor: Colors.orange,
              ),
              onDaySelected: (date, events) {
                print((date.millisecondsSinceEpoch));
                showBottomSheet(context, date);
              },
            )
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context, DateTime date) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
//        isDismissible: false,
        context: context,
        builder: (BuildContext bContext) {
          return Container(
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              color: Colors.green,
            ),
            child: Center(
                child: Text(date.day.toString() +
                    "-" +
                    date.month.toString() +
                    "-" +
                    date.year.toString())),
          );
        });
  }
}
