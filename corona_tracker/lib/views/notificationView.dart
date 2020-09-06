import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Shownotification extends StatefulWidget {
  @override
  _ShownotificationState createState() => _ShownotificationState();
}

class _ShownotificationState extends State<Shownotification> {
  var height;
  var width;
  String valueNew;
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  String _show;

  /*void getMalde() async{
    String  uid = await storage.read(key: "uid");
   await Firestore.instance.collection("users").document(uid).get().then((value) => null);
  }*/
  Future<void> getSession() async {
    var uid = await storage.read(key: 'uid');
    DocumentSnapshot dn = await Firestore.instance
        .collection('users')
        .document(uid).get();
    return await storage.write(
        key: 'malade', value: dn.data['malade'].toString());
  }

  Future<String> readSession() async {
    return await storage.read(key: 'malade');
  }

  Future<void> getMalade(String valueNew) {
    if (valueNew == "true") {
      _show = "true";
    }
    else {
      _show = "false";
    }
  }

  @override
  void initState() {
    // TODO: implement initState


    getSession().then((_) =>
        readSession().then((value) =>
            setState(() {
              getMalade(value);
            })
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    switch (_show) {
      case "true":
        return Scaffold(
            body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Center(
                        child: Icon(Icons.warning, color: Colors.red, size: 100)

                    ),
                    Center(
                        child: Text("Pay attention", style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),)

                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    Center(
                        child: Text(
                            "For your benefit, follow these instructions:",
                            style: TextStyle(fontSize: 16,
                                color: Colors.red,
                                decoration: TextDecoration.underline))),
                    SizedBox(
                      height: height / 30,
                    ),
                    Text(
                        "1-call ahead to your local emergency facility: Notify the operator about your symptoms",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text("2-Stay at home"),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text("3-Stay at an isolate room"),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text("4-Wear your mask"),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text(
                        "5-Cover your coughs and sneezes with a tissue and throw the tissue in the trash"),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text(
                        "6-Wash your hands often with soap and water for at least 20 seconds"),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text(
                        "7-If soap and water are not readily available, use an alcohol-based hand sanitizer with at least 60% alcohol"),

//
//.

                  ],


                )
            )
        );
      case "false":
        return Scaffold(
            body: SingleChildScrollView(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Center(
                        child: Icon(
                            Icons.healing, color: Colors.green, size: 100)

                    ),

                    Center(
                        child: Text(
                            "For your benefit, follow these instructions:",
                            style: TextStyle(fontSize: 16,
                                color: Colors.blue,
                                decoration: TextDecoration.underline))),
                    SizedBox(
                      height: height / 30,
                    ),
                    Text("1-No handshaking or kissing on the cheeks "),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text("2-Clean your hands frequently "),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text("3-Keep your hands away from your face  "),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text("4-Hygienic coughing and sneezing"),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text("5-Discard used tissues immediately"),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text("6-Ventilate regularly"),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text("7-Keep your distance and avoid crowds"),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text("8-Pay attention to first symptoms"),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text("9-Do not share objects"),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text("10-Wear your mask"),

//
//.

                  ],


                )
            ));
      default:
        return Container();

    }
  }
}