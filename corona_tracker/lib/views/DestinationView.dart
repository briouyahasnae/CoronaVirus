import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_tracker/main.dart';
import 'package:corona_tracker/views/Fichierep.dart';
import 'package:corona_tracker/views/Home.dart';
import 'package:corona_tracker/views/questionnaire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:corona_tracker/views/Maps.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:corona_tracker/views/login.dart';
import 'package:http/http.dart';

import 'bottom-navbar-bloc.dart';




class DestinationView extends StatefulWidget {
  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
   BottomNavBarBloc _bottomNavBarBloc;
   Future<Widget> _quest;
Widget t;



  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }


  Future<Widget> getRep() async{
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
         }
           });
         });

     return t;

}
deconnecter() async{
  dynamic email = await FlutterSession().get("email");
  email = null;
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Login()),
  );
}
   @override
   void initState() {
     super.initState();
     _bottomNavBarBloc = BottomNavBarBloc();
     getRep();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Corona tracker"),
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
      body: StreamBuilder<NavBarItem>(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,

        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.HOME:
              return  Home();
            case NavBarItem.ALERT:
              FutureBuilder(
                future:getRep(),
                 builder: (BuildContext context, AsyncSnapshot  snapshot1) {
                  if(snapshot1.hasData){
                   t=Fichierep();
                  }
                  t= Questionnaire();
                 }
              );
                 return t;

              case NavBarItem.SETTINGS:
              return Maps();
          }

        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                title: Text('Home'),
                icon: Icon(Icons.home),
                backgroundColor: Colors.blue
              ),
              BottomNavigationBarItem(
                title: Text('Test'),
                icon: Icon(Icons.list),
                backgroundColor: Colors.greenAccent
              ),
              BottomNavigationBarItem(
                title: Text('Maps'),
                icon: Icon(Icons.location_on),
                backgroundColor: Colors.red
              ),
            ],
            fixedColor: Colors.blueAccent,
            currentIndex: snapshot.data.index,
            onTap: _bottomNavBarBloc.pickItem,
          );
        },
      ),
    );
  }
  }