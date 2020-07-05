import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 170.0, left: 20.0, right: 20.0),
      padding: const EdgeInsets.all(10.0),
      height: 120.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.white),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      "Clock In",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: 5.0,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Clock In",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        const Text("have a nice day"),
                        Container(
                          width: 10.0,
                        ),
                        const Icon(
                          Icons.mail,
                          color: Colors.green,
                          size: 17.0,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: const Align(
              alignment: Alignment.centerRight,
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                radius: 45.0,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40.0,
                  child: const Text("Clock In"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
