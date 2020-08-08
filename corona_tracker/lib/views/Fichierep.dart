import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_session/flutter_session.dart';
class Fichierep extends StatefulWidget {
  @override
  _FichierepState createState() => _FichierepState();
}



class _FichierepState extends State<Fichierep> {
  final storage = new FlutterSecureStorage();
  var _result;
  Future<dynamic> User;
  // ignore: always_specify_types
  Future<dynamic> getCurrentUser() async{
    try {
      final dynamic email = await storage.read(key: 'email');
      Firestore.instance
          .collection('questionnaire')
          .getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((DocumentSnapshot result)  {
          if (result.data['email'] == email) {
            setState(() {
             _result= result.data;
            });

        }});
      });
    }catch (e) {
      print(e);
    }

  }

  Widget _bigDisplay() {
   return  FutureBuilder<dynamic>(
      future:User,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
     switch (snapshot.connectionState) {
       case ConnectionState.active:
       case ConnectionState.waiting:
         return Center(
             child:Text("Loading..."));
       default :
         if (snapshot.hasError)
           return Text('Error: ${snapshot.error}');
         else {
        return Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Personal informations"),
                    Text(_result["R1"].toString())
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Column 2"),
                    ],
                  ))
            ]);
      }} });
  }


  Widget _smallDisplay() {

    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Age:${_result['Age']}",
                style: TextStyle(
                fontSize: 13.0, fontWeight: FontWeight.bold),),
              ],
            )),


     Row(

    mainAxisAlignment: MainAxisAlignment.center,

    children: <Widget>[
    Text(
    'new or worsening cough :',
    style: TextStyle(
    fontSize: 13.0, fontWeight: FontWeight.bold),
    ),

    Text(_result['R1'].toString()),
    ]),

    Row(

    mainAxisAlignment: MainAxisAlignment.center,

    children: <Widget>[
    Text(
    'difficulty breathing :',
    style: TextStyle(
    fontSize: 13.0, fontWeight: FontWeight.bold),
    ),

    Text(_result['R2'].toString()),
    ]),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,

    children: <Widget>[
    Text(
    'new loss of smell or taste:',
    style: TextStyle(
    fontSize: 13.0, fontWeight: FontWeight.bold),
    ),

    Text(_result['R3'].toString()),
    ]),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,

    children: <Widget>[
    Text(
    'fatigue or weakness:',
    style: TextStyle(
    fontSize: 13.0, fontWeight: FontWeight.bold),
    ),

    Text(_result['R4'].toString()),
    ]),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,

    children: <Widget>[
    Text('temperature >= 38°C :',
    style: TextStyle(
    fontSize: 13.0, fontWeight: FontWeight.bold),
    ),

    Text(_result['R5'].toString()),
    ]),
      ]);
  }
@override
void initState() {
    // TODO: implement initState
    super.initState();
    User=getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 500) {
          return _bigDisplay();
        } else {
          return _smallDisplay();
        }
      }),
    );
  }
}