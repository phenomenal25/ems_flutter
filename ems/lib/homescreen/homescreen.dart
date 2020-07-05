import 'package:cached_network_image/cached_network_image.dart';
import 'package:ems/colors.dart';
import 'package:ems/complain/complains.dart';
import 'package:ems/document/documents.dart';
import 'package:ems/event/events.dart';
import 'package:ems/holidays/holidays.dart';
import 'package:ems/provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../attendence/attendence.dart';
import '../homescreen/clock.dart';
import '../leave/myleaves.dart';
import '../profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final gridList = [
    "Attendence",
    "Complain",
    "Document",
    "Event",
    "Holiday",
    "Leave",
    "Connect",
    "Poll"
  ];
  var _username;

  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      _username = sharedPreferences.getString("fname");
    });
  }

  void profileScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProfile()));
  }

  Widget box(String name) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(height: 10.0),
          const Icon(Icons.account_balance_wallet),
          Container(height: 20.0),
          Text(name),
          Container(height: 10.0)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).setImage =
        sharedPreferences.getString("image");
    String image = Provider.of<UserProvider>(context).getImage;
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      appBar: AppBar(
        title: const Text("Employee Friendly"),
        backgroundColor: Color(0xff3E5B7A),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(height: 250.0, color: Color(0xff3E5B7A)),
              Container(
                height: 180.0,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
//            flex: 3,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: const Text(
                                          "Good Day",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            // fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          // _user_name == null ? "" : _user_name,
                                          _username ?? "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            // fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      "What do you want \nto do today",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => profileScreen(context),
                              child: Hero(
                                tag: "image",
                                child: Container(
                                  height: 100.0,
                                  width: 100.0,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            SpinKitCircle(
                                              color: Colors.white,
                                            ),
                                        imageUrl: image),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ClockPage(),
              Container(
                margin:
                    const EdgeInsets.only(top: 310.0, left: 20.0, right: 20.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: true,
                  itemCount: gridList.length,
                  physics: ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        launchScreen(gridList, index, context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade200,
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Expanded(
                                flex: 2, child: const Icon(Icons.add_a_photo)),
                            Expanded(child: Text(gridList[index]))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      )),
    );
  }

  void launchScreen(List list, int i, BuildContext context) {
    if (list[i] == "Leave") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyLeaves()));
    } else if (list[i] == "Attendence") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Attendence()));
    } else if (list[i] == "Complain") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Complains()));
    } else if (list[i] == "Document") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Documents()));
    } else if (list[i] == "Event") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Events()));
    } else if (list[i] == "Holiday") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Holiday()));
    }
  }
}
