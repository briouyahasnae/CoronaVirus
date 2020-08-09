import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_tracker/classes/Ip_info.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:convert';
class Maps extends StatefulWidget {
  @override
  _Maps createState() => _Maps();
}

class _Maps extends State<Maps> {
  final storage = new FlutterSecureStorage();
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  final Map<String, Circle> _circle= {};
  IP_info ip_info;
  List<Circle> list;
  LatLng _center=LatLng(33.01887,-8.01458) ;
  bool _isLoading=false;
  _getPublicIP() async {
    try {
      const url = 'http://ip-api.com/json';

      final response = await http.get(url);
      if (response.statusCode == 200) {
        ip_info = IP_info.fromJson(json.decode(response.body));
        print(ip_info.toString());

        setState(() {
          _isLoading = false;
          setState(() {
            _center=  LatLng(ip_info.x, ip_info.y);
          });


        });
      } else {
        // The request failed with a non-200 code
        setState(() {
          _center=  LatLng(33.01887,-8.01458);

        });

      }
    } catch (e) {
      print(e);
    }
  }



  void _onMapCreated(GoogleMapController controller) {
    _getLocation();
    mapController = controller;
  }
  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });
    String value = await storage.read(key: "emai");
    print(value);
    int count=0;
    Firestore.instance
        .collection('users')
        .getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        if (result.data['email'] != value) {
          if (result.data['malade'] == true) {
            setState(() {
              Circle circle=   Circle( //radius marker
                  circleId: CircleId("current${count}"),
                  center: LatLng(result.data['x'], result.data['y']),
                  radius: 4000,
                  fillColor: Colors.green.withOpacity(0.5),
                  strokeColor: Colors.green,
                  strokeWidth: 3,
                  visible: true
              );
              _circle["current index $count"]=circle;
            });
          }

        }
        count++;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPublicIP();
    print(_center);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 5.0,
        ),
        markers: _markers.values.toSet(),
        circles:Set<Circle>.of(_circle.values),
      ),
    );
  }
}