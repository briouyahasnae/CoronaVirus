import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_tracker/classes/client.dart';
import 'package:corona_tracker/main.dart';
import 'package:corona_tracker/views/navigation2.dart';
import 'package:corona_tracker/views/questionnaire.dart';
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
  var now=new DateTime.now().toUtc().millisecondsSinceEpoch;
  Future _future;
  double width;
  double height;
  var age;
  var weight,tall,r1,r2,r3,r4,r5,time;
  Future<dynamic> User;
  Client client;
  final MyHomePage homee=new MyHomePage();
  // ignore: always_specify_types
  void repeat() async {
    final dynamic email = await storage.read(key: 'email');
    var uid=await storage.read(key: "uid");
    Firestore.instance
        .collection('users')
        .document(uid).updateData(<String, dynamic>{
      "malade": false,
      "Reponse": false,
      "x": null,
      "y": null
    });
    Firestore.instance
        .collection('questionnaire')
        .getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((DocumentSnapshot result) {
        if (result.data['email'] == email) {
          result.reference.delete();
        }
        MyHomePage.currentIndex=1;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>MyHomePage()),
          ModalRoute.withName("home"),
        );
      });
    });
  }

  Future<dynamic> getCurrentUser() async {
    var email=await storage.read(key: "email");
    try {
      Firestore.instance
          .collection('questionnaire')
          .getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((DocumentSnapshot result) {
          if (result.data['email'] == email) {
            _result=result;
            client=Client.from(_result);
            setState(() {
              age=client.age;
              weight=client.weight;
              tall=client.height;
              r1=client.r1;
              r2=client.r2;
              r3=client.r3;
              r4=client.r4;
              r5=client.r5;
              time=client.timestamp;
            });
          }
        });
      });
      print(_result);

    }
    catch (e) {
      print(e);
    }
  }

  Widget _bigDisplay() {
    return FutureBuilder<dynamic>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                  child: Text("Loading..."));
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

                            Text("Age:",

                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,),),

                            Text(age.toString(),
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(width: width / 30),
                            Text("Height:",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black

                              ),),
                            Text(tall.toString()),
                            SizedBox(width: width / 30),
                            Text("Weight:",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color:
                                  Colors.black),),
                            Text(weight.toString()),
                            SizedBox(
                              width: width / 10, height: height / 10,),
                            RaisedButton.icon(onPressed: () {
                              repeat();
                            },
                                icon: Icon(Icons.replay),
                                label: Text("Repeat the test"))
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'new or worsening cough :',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color:
                                    r1.toString().toString() ==
                                        'yes' ? Colors.red : Colors
                                        .green),
                              ),

                              Text(r1.toString()),
                              SizedBox(height: height / 30),
                              Text(
                                'difficulty breathing :',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: r2
                                        .toString()
                                        .toString() == 'yes'
                                        ? Colors.red
                                        : Colors.green),
                              ),

                              Text(r2.toString()),
                              SizedBox(height: height / 30),
                              Text(
                                'new loss of smell or taste:',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: r3
                                        .toString()
                                        .toString() == 'yes'
                                        ? Colors.red
                                        : Colors.green),
                              ),

                              Text(r3.toString()),
                              SizedBox(height: height / 30),
                              Text(
                                'fatigue or weakness:',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: r4
                                        .toString()
                                        .toString() == 'yes'
                                        ? Colors.red
                                        : Colors.green),
                              ),

                              Text(r4.toString()),
                              SizedBox(height: height / 30),
                              Text('temperature >= 38°C :',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: r5
                                        .toString()
                                        .toString() == 'yes'
                                        ? Colors.red
                                        : Colors.green),
                              ),

                              Text(r5.toString()),
                            ],
                          ))
                    ]);
              }
          }
        });
  }


  Widget _smallDisplay() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text("Age:",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),),

            Text(age.toString()),

          ],
        ),
        SizedBox(height: height / 30),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Height:",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent

                ),),
              Text(tall.toString()),
            ]),


        SizedBox(height: height / 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text("Weight:",
              style: TextStyle(
                  fontSize: 14.0, fontWeight: FontWeight.bold, color:
              Colors.blueAccent),),
            Text(weight.toString()),

          ],

        ),

        SizedBox(height: height / 30),
        Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Text(
                'new or worsening cough :',
                style: TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.bold, color:
                r1.toString().toString() == 'yes'
                    ? Colors.red
                    : Colors.green),
              ),

              Text(r1.toString()),
            ]),
        SizedBox(height: height / 30),
        Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Text(
                'difficulty breathing :',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color:r2.toString().toString() == 'yes'
                        ? Colors.red
                        : Colors.green),
              ),

              Text(r2.toString()),
            ]),
        SizedBox(height: height / 30),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Text(
                'new loss of smell or taste:',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color:r3.toString().toString() == 'yes'
                        ? Colors.red
                        : Colors.green),
              ),

              Text(r3.toString()),
            ]),
        SizedBox(height: height / 30),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Text(
                'fatigue or weakness:',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: r4.toString().toString() == 'yes'
                        ? Colors.red
                        : Colors.green),
              ),

              Text(r4.toString()),
            ]),
        SizedBox(height: height / 30),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Text('temperature >= 38°C :',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: r5.toString().toString() == 'yes'
                        ? Colors.red
                        : Colors.green),
              ),

              Text(r5.toString()),

            ]),
        SizedBox(height: height / 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(onPressed: (){
                repeat();
              },
                  icon: Icon(Icons.replay),
                  label: Text("Repeat the test"))

            ]),
      ],);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future=getCurrentUser();
    setState(() {
      MyHomePage.currentIndex=1;
    });
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery
        .of(context)
        .size
        .width;
    height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(

      body: LayoutBuilder(builder: (context, constraints) {
        if(now-int.parse(time as String)>15){
        if (constraints.maxWidth > 500) {
          return _bigDisplay();
        } else {
          return _smallDisplay();
        }
      }
      else{
      repeat();}
      }),
    );
  }
}