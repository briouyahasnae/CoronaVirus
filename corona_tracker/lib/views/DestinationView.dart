import 'package:flutter/material.dart';
import 'package:corona_tracker/views/Home.dart';
import 'package:corona_tracker/views/questionnaire.dart';
import 'package:corona_tracker/views/login.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:corona_tracker/views/Maps.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class DestinationView extends StatefulWidget {

  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {

  deconnecter() async{
    dynamic email=await FlutterSession().get("email");
     email=null;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );

  }
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  var home;
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Questionnaire(),
    Maps()
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_children[_currentIndex].toString()),
        actions: <Widget>[
        IconButton(
          icon:Icon(Icons.exit_to_app,size: 30,color: Colors.white,),
          onPressed: () {
            deconnecter();
          },
        ),
        ],

        automaticallyImplyLeading: false,
      ),
     /* floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.fullscreen_exit),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/logout");
        },
      ),*/
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 20),
          Icon(Icons.list, size: 20),
          Icon(Icons.map, size: 20),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 800),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
        body: Container(
          child: _children[_page]
          ),
        );
  }
}