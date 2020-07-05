import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'event_detail.dart';

class EventData {
  final List images;
  final String description, title;

  EventData(this.images, this.description, this.title);
}

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final _url = "https://intern.fmv.cc/EmployeeAdmin/employee-event";

  List _data;

  Future<void> fetchEvent() async {
    var response = await http.get(_url);
    var decode = json.decode(response.body);
    _data = decode["data"];
    setState(() {});
  }

  @override
  void initState() {
    fetchEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Event"),
          centerTitle: true,
        ),
        body: _data == null
            ? SpinKitThreeBounce(color: Theme.of(context).appBarTheme.color)
            : ListView.builder(
                itemBuilder: (ctx, i) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => EventDetail(EventData(
                                _data[i]["image"],
                                _data[i]["description"],
                                _data[i]["event_title"])))),
                    child: Card(
                      elevation: 7.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      margin: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://intern.fmv.cc/EmployeeAdmin/assets/uploads/" +
                                      _data[i]["image"][0],
                              placeholder: (context, _) =>
                                  SpinKitPouringHourglass(
                                color: Theme.of(context).appBarTheme.color,
                              ),
                              fit: BoxFit.cover,
                              height: 200.0,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                            bottom: 10.0,
                            right: 10.0,
                            child: Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                _data[i]["event_title"],
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: _data.length,
              ));
  }
}
