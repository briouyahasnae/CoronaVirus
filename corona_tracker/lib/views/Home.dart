import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clay_containers/clay_containers.dart';
import 'package:flag/flag.dart';
import 'package:corona_tracker/classes/Ip_info.dart';

class Home extends StatefulWidget {
  int index;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var code;
  var country;
  var username;
  var r;
  var d;
  dynamic email;
  IP_info ip_info;
  bool _isLoading=false;

    Future getData() async {
      try {
        const url = 'http://ip-api.com/json';

        final response = await http.get(url);
        if (response.statusCode == 200) {
          ip_info = IP_info.fromJson(json.decode(response.body));
          print(ip_info.toString());

          setState(() {
            _isLoading = false;
            country=ip_info.country;
            code=ip_info.country_code;
          });
        } else {
          // The request failed with a non-200 code
          print(response.statusCode);
          print(response.body);
        }
      } catch (e) {
        print(e);
      }


    final String apiUrl = "https://api.thevirustracker.com/free-api?countryTotal=${ip_info.country_code}";
    // var url = 'https://api.thevirustracker.com/free-api?countryTotal='code;
    var result = await http.get(apiUrl);
    if (result.statusCode == 200) {
      /* r=
    print(r);
    deaths=r[0]["total_new_deaths_today"];
    newCases=r[0]["total_new_cases_today"];
    newRecovered=r[0]["total_active_cases"];
    totaleCases=r[0]["total_cases"];
    totaleRecov=r[0]["total_recovered"];
    totaleDeath=r[0]["total_deaths"];
    seriousCases=r[0]["total_serious_cases"];*/
      print(json.decode(result.body)['countrydata']);
      return json.decode(result.body)['countrydata'];

    }
    else{
     throw Exception ('Failed to load Data');
    }

  }
@override
void initState() {
    // TODO: implement initState
    super.initState();
     r= getData();
     print("Im her $r");
  }
  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
    body: FutureBuilder(
    future: r,
        builder: (context, snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
      case ConnectionState.waiting:
    return Center(
      child:Text("Loading..."));
    default :
    if (snapshot.hasError)
    return Text('Error: ${snapshot.error}');
    else {
      if(snapshot.hasData) {
        return
          ListView(
              children: <Widget>[
                SizedBox(
                  height: height/20,
                ),
                Padding(
                    padding: EdgeInsets.only(top:(height*0.05)-20),
                    child: ClayContainer(
                        color: Colors.white,
                        height: height*0.2,
                        borderRadius: 20,
                        depth: 30,
                        spread: 30,
                        child: Column(
                            children: [
                              Text(
                               country,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Flag(code, width: width/10, height: height/10),
                            ])
                    )),
                SizedBox(
                  height: height/20,
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
                  height: height/20,
                ),
                Row(
                    children:
                    <Widget>[
                      ClayContainer(
                        color: Colors.white,
                        height: height/5,
                        width: (width/2)-10,
                        borderRadius: 20,
                        child:
                        Center(
                          child:
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: height/20,
                              ),
                              Text("Total cases",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: height/20,
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
           width: width/30,
         ),
                      ClayContainer(
                        color: Colors.white,
                        height: height/5,
                        width: (width/2)-10,
                        borderRadius: 20,
                        child:
                        Center(
                          child:
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: height/20,
                              ),
                              Text("Total Deaths",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: height/20,
                              ),
                              Text(
                                snapshot.data[0]["total_deaths"].toString(),
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
                  height: height/40,
                ),
                Row(
                  children: <Widget>[
                    ClayContainer(
                      color: Colors.white,
                      height: height/5,
                      width: (width/2)-10,
                      borderRadius: 20,
                      child:
                      Center(
                        child:
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: height/20,
                            ),
                            Text("Recoverd Cases",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: height/20,
                            ),
                            Text(
                              snapshot.data[0]["total_recovered"].toString(),
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
                  height: height/40,
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
                  height: height/40,
                ),
                Row(
                    children: <Widget>[
                      ClayContainer(
                        color: Colors.white,
                        height:( height/5)-10,
                        width:  width/3,
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
                            snapshot.data[0]["total_serious_cases"].toString(),
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
                  height: height/40,
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
                  height: height/50,
                ),
                Row(
                  children: <Widget>[
                    ClayContainer(
                      color: Colors.white,
                      height:( height/5.5)-10,
                      width:  (width/3.5)+1,
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
                          snapshot.data[0]["total_new_cases_today"].toString(),
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
                      width: width*0.06,
                    ),
                    ClayContainer(
                      color: Colors.white,
                      height:( height/5.5)-10,
                      width:  (width/3.5)+1,
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
                          snapshot.data[0]["total_active_cases"].toString(),
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
                      width: width*0.06,
                    ),
                    ClayContainer(
                      color: Colors.white,
                      height:( height/5.5)-10,
                      width:  (width/3.5)+1,
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
                          snapshot.data[0]["total_new_deaths_today"].toString(),
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
      return Text("No Data");
    }}
    return null;
    }));
  }
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
