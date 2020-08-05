import 'package:corona_tracker/views/DestinationView.dart';
import 'package:corona_tracker/views/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/views/Home.dart';
import 'package:corona_tracker/views/Fichierep.dart';
import 'package:corona_tracker/views/questionnaire.dart';
import 'package:flutter_session/flutter_session.dart';
var email;
var home;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   email = await FlutterSession().get("email");

  /*await CountryCodes.init();*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  dynamic gethome() {
    if (email != null) {
      home = SplashScreen();
    }
    home=DestinationView();
    return home;
  }
  final backgroundColor = const Color(0xFF3C3B58);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Corona Tracker",
      theme: ThemeData(primaryColor: backgroundColor),
      home:gethome(),
      routes: <String, WidgetBuilder>{
        '/quest': (BuildContext context) => Questionnaire(),
        '/home': (BuildContext context) => Home(),
      },
    );
  }
}
