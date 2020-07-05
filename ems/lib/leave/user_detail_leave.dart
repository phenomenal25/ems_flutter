import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserDetail extends StatelessWidget {
  UserDetail({this.image, this.username, this.id, this.designation});
  final image, username, id, designation;
  Widget text(String s, Color color) => Padding(
        padding: const EdgeInsets.only(top: 5.0, left: 10.0),
        child: Text(
          s ?? "",
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          margin: const EdgeInsets.all(20.0),
          elevation: 10.0,
          //shadowColor: Colors.teal,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 90.0,
              width: 90.0,
              imageUrl: image,
              placeholder: (context, _) =>
                  SpinKitCircle(color: Theme.of(context).appBarTheme.color),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(username, Theme.of(context).appBarTheme.color),
            text(designation, Theme.of(context).appBarTheme.color),
            text("Id:$id", Theme.of(context).appBarTheme.color),
          ],
        )
      ],
    );
  }
}
