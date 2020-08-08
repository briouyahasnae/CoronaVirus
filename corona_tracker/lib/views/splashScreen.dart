import 'dart:async';
import 'package:corona_tracker/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:corona_tracker/main.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = new FlutterSecureStorage();
  final splashDelay =11;
  final backgroundColor=const Color(0xFFf4f4f6);

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
   String value = await storage.read(key: "email");
    Widget home ;
    if(value == null){
      home=new Signup();
    }
    else {
      home = MyHomePage();
    }
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder:(BuildContext context) =>
        home ));
  }

  @override
  Widget build(BuildContext context) {
   var width= MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color:backgroundColor ,
        child: SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,//Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Flexible(
                 child: Text(
                      "Welcome",
                      style:TextStyle(
                        color:const Color(0xFF272343),
                        fontSize:30,
                        fontWeight: FontWeight.bold,

                      )
                  ),
        ),
                  Image.asset('assets/images/logo.png',
                    width: width/4,
                    height: height/4,
                  ),

               Flexible(
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:<Widget>[
                            Text(
                                "Let's act against ",
                                style:TextStyle(
                                  color:const Color(0xFF272343),
                                  fontSize:20,
                                  fontWeight: FontWeight.bold,

                                )
                            ),
                            Text(
                                "Covid-19",
                                style:TextStyle(
                                  color:Colors.green,
                                  fontSize:20,
                                  fontWeight: FontWeight.bold,

                                )
                            ),
                         ]
                      )
    ),

                  Column(
                      mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                      padding:  EdgeInsets.only(top:height/10),
                     child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
                        semanticsLabel: "Loading ...",
                      ),

                      ) ],
                  ),
               ] ),

            ),
        ),
      );
  }
}
