import 'package:corona_tracker/views/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/views/Home.dart';
import 'package:corona_tracker/views/questionnaire.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*await CountryCodes.init();*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final backgroundColor = const Color(0xFF3C3B58);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Corona Tracker",
      theme: ThemeData(primaryColor: backgroundColor),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/quest': (BuildContext context) => Questionnaire(),
        '/home': (BuildContext context) => Home(),
      },
    );
  }
}
