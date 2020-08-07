import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_tracker/views/Fichierep.dart';
import 'package:corona_tracker/views/Home.dart';
import 'package:corona_tracker/views/questionnaire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:corona_tracker/views/Maps.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),

    );
  }
}

/// A future that completes successfully.
Future<Widget> getRep() async{
  Widget t;
  dynamic email = await FlutterSession().get("email");
  Firestore.instance
      .collection('users')
      .getDocuments().then((QuerySnapshot querySnapshot) {
    // ignore: avoid_function_literals_in_foreach_calls
    querySnapshot.documents.forEach((DocumentSnapshot result) {
      if (result.data['email'] == email) {
        if (result.data['Reponse'] == true) {
          t = Fichierep();
        }
        else {
          t = Questionnaire();
        }
        print(t.toString());
      }
    });
  });
  return t;

}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(height: 50, child: Center(child: GoodButton())),
        ],
    ),
    ),
    );

  }
}

class GoodButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   /* return Futuristic<Widget>(
      futureBuilder: () => getRep(),
      initialBuilder: (_, start) => RaisedButton(child: Text('Good button example'), onPressed: start),
      busyBuilder: (_) => CircularProgressIndicator(),
      dataBuilder: (_, data) => Text(data.toString()),
    );*/
  }

}