import 'package:ems/event/events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class EventDetail extends StatelessWidget {
  final EventData _eventData;

  EventDetail(this._eventData);

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.8,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(_eventData.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            height: 250.0,
            child: PageView(
              controller: _pageController,
              children: _eventData.images
                  .map((image) => Card(
                        margin: const EdgeInsets.all(10.0),
                        elevation: 7.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        //shadowColor: Theme.of(context).appBarTheme.color,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            "https://intern.fmv.cc/EmployeeAdmin/assets/uploads/" +
                                image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Html(
                data: _eventData.description,
              ),
            ),
          )
        ],
      ),
    );
  }
}
