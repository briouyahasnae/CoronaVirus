import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:corona_tracker/classes/CovidCases.dart';
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = false;
  List covid_info;
  List<dynamic> data;
  @override
  void initState() {
    _isLoading=true;
    _getPublicIP();
  }

  _getPublicIP() async {
    try {

      const url = 'https://api.thevirustracker.com/free-api?countryTotal=DZ';

      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> covid_info = json.decode(response.body);
        data = covid_info["countrydata"];
        setState(() {
          _isLoading = false;
        });
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
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,

          ),
            child:Text(data[0]["total_cases"].toString())
        )
    );
  }
}