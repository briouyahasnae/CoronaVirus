import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flag/flag.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<dynamic>> _tasks;


  var code;
  var country;
  var username;
  var r;
  Future<List<dynamic>> _fetchUsers() async {
    dynamic email = await FlutterSession().get("email");
    var db = Firestore.instance
        .collection('users')
        .getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        if (result.data['email'] == email) {
          code = result.data['code'];
          username = result.data['username'];
          country = result.data['country'];
        }
      });
    });
    final String apiUrl = "https://api.thevirustracker.com/free-api?countryTotal=${code}";
    // var url = 'https://api.thevirustracker.com/free-api?countryTotal='code;
    var result = await http.get(apiUrl);
    if (result.statusCode == 200) {
      /* r= json.decode(result.body)['countrydata'];
    print(r);
    deaths=r[0]["total_new_deaths_today"];
    newCases=r[0]["total_new_cases_today"];
    newRecovered=r[0]["total_active_cases"];
    totaleCases=r[0]["total_cases"];
    totaleRecov=r[0]["total_recovered"];
    totaleDeath=r[0]["total_deaths"];
    seriousCases=r[0]["total_serious_cases"];*/
      r = json.decode(result.body)['countrydata'];
    }
    else{
     r= throw Exception ('Failed to load Data');
    }

    return r;
  }
  @override
  void initState() {
    _tasks = _fetchUsers();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _tasks,
            builder: (BuildContext context, AsyncSnapshot  snapshot) {
              if (snapshot.hasData) {
                return ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: ClayContainer(
                              color: Colors.white,
                              height: 100,
                              borderRadius: 20,
                              depth: 30,
                              spread: 30,
                              child: Column(
                                  children: [
                                    Text(
                                      /* children: <Widget>[
    Container(child:
    Text(*/
                                      country,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Flag(code, width: 40, height: 40,),
                                  ])
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child:
                        Container(
                          child: Text(
                            "Global Stats",
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              inherit: true,
                              color: Colors.black,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          children:
                          <Widget>[
                            ClayContainer(
                              color: Colors.white,
                              height: 100,
                              width: 150,
                              borderRadius: 20,
                              child:
                              Center(
                                child:
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("Total cases",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(snapshot.data[0]["total_cases"]
                                        .toString(),
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ClayContainer(
                              color: Colors.white,
                              height: 100,
                              width: 150,
                              borderRadius: 20,
                              child:
                              Center(
                                child:
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("Total Deaths",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      snapshot.data[0]["total_deaths"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          ClayContainer(
                            color: Colors.white,
                            height: 100,
                            width: 150,
                            borderRadius: 20,
                            child:
                            Center(
                              child:
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Recoverd Cases",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    snapshot.data[0]["total_recovered"]
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Active Cases",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          inherit: true,
                          letterSpacing: 0.4,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          children: <Widget>[
                            ClayContainer(
                              color: Colors.white,
                              height: 100,
                              width: 100,
                              borderRadius: 75,
                              curveType: CurveType.concave,
                              child: Column(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      20, 20, 0, 5),),
                                ClayText(
                                  "Active cases ", textColor: Colors.black,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      20, 10, 0, 5),),
                                //  ClayText(pointer.coronaCurrent, textColor: Colors.yellow,),
                                Text(
                                  snapshot.data[0]["total_serious_cases"]
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              ),


                            ),
                          ]
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "New cases",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          inherit: true,
                          letterSpacing: 0.4,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          ClayContainer(
                            color: Colors.white,
                            height: 100,
                            width: 100,
                            borderRadius: 50,
                            curveType: CurveType.concave,
                            child: Column(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    20, 20, 0, 5),),
                              ClayText("New infected",
                                textColor: Colors.black,),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    20, 10, 0, 5),),
                              //  ClayText(pointer.coronaCurrent, textColor: Colors.yellow,),
                              Text(
                                snapshot.data[0]["total_new_cases_today"]
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            ),


                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ClayContainer(
                            color: Colors.white,
                            height: 100,
                            width: 100,
                            borderRadius: 60,
                            curveType: CurveType.concave,
                            child: Column(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    20, 20, 0, 5),),
                              ClayText(
                                "Recovered", textColor: Colors.black,),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    20, 10, 0, 5),),
                              //  ClayText(pointer.coronaMild, textColor: Colors.orangeAccent,),
                              Text(
                                snapshot.data[0]["total_active_cases"]
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ClayContainer(
                            color: Colors.white,
                            height: 100,
                            width: 100,
                            borderRadius: 75,
                            curveType: CurveType.concave,
                            child: Column(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    20, 20, 0, 5),),
                              ClayText(
                                "Deaths", textColor: Colors.black,),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    20, 10, 0, 5),),
                              //  ClayText(pointer.coronaMild, textColor: Colors.orangeAccent,),
                              Text(
                                snapshot.data[0]["total_new_deaths_today"]
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            ),
                          ),
                        ],
                      ),

                    ].toList()
                );
              }
                return
                  (
                      Center(
                          child: CircularProgressIndicator()
                      )
                  );

            }));
  }
/*class _HomeState extends State<Home> {
  Map<String, dynamic> covid_info;
  bool _isLoading = false;
  @override
  void initState() {
    _isLoading=true;
    _getPublicIP();
  }

  _getPublicIP() async {
    dynamic email=await FlutterSession().get("email");
    var code=null;
    var db = Firestore.instance
        .collection('users')
        .getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        if (result.data['email'] ==email) {
                  code=result.data['code'];
        }
      });
      });

    try {
      var url='https://api.thevirustracker.com/free-api?countryTotal=${code}';
     // var url = 'https://api.thevirustracker.com/free-api?countryTotal='code;

      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        return json.decode(response.body)['countrydata'];

      }
      else {
        // The request failed with a non-200 code
        print(response.statusCode);
        print(response.body);
      }



    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
            child: _isLoading
        ? Center(
        child: CircularProgressIndicator(),
        ) : SingleChildScrollView(
        child: ClayContainer(
        child: Column(
    children: <Widget>[
      Padding(
          padding: const EdgeInsets.all(8.0),
          child:ClayContainer(
            color: Colors.white,
            height: 200,
            width: 200,
            child:Text(covid_info["total_recovered"] as String)
          )


        )
  ])))));
  }
*/
}
