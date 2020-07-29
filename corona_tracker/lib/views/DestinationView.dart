import 'package:flutter/material.dart';
import 'package:corona_tracker/views/Home.dart';
import 'package:corona_tracker/views/questionnaire.dart';
import 'package:corona_tracker/views/login.dart';
import 'package:flutter_session/flutter_session.dart';

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
  int _currentIndex = 0;
  final List<Widget> _children = [
    new Home(),
   new Questionnaire()
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
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            title: new Text('Test Covid-19'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
      ),
    );
  }
}