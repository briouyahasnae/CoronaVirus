import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_tracker/views/Fichierep.dart';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:corona_tracker/views/Home.dart';
import 'package:corona_tracker/views/questionnaire.dart';
import 'package:corona_tracker/views/login.dart';
import 'package:flutter_session/flutter_session.dart';

class DestinationView extends StatefulWidget {
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  static Widget quest;

  deconnecter() async {
    dynamic email = await FlutterSession().get("email");
    email = null;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  int _currentIndex = 0;

  final firestoreInstance = Firestore.instance;
  static Future<String> getQuest() async {
    dynamic email = await FlutterSession().get("email");

    var data = Firestore.instance
        .collection('users')
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        if (result.data['email'] == email) {
          if (result.data['Reponse'] == true) {
            return Fichierep();
          } else {
            return Questionnaire();
          }
        }
      });
    });
  }

  final List<Widget> _children = [
    new Home(),
    FutureBuilder<String>(
        future: getQuest(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data);
          }
        }),
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
            icon: Icon(
              Icons.exit_to_app,
              size: 30,
              color: Colors.white,
            ),
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
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }
}
