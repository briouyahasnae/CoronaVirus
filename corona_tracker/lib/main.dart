import 'package:corona_tracker/views/DestinationView.dart';
import 'package:corona_tracker/views/Login.dart';
import 'package:corona_tracker/views/Maps.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/views/Home.dart';
import 'package:corona_tracker/views/bottom_navy_bar.dart';
import 'package:corona_tracker/views/questionnaire.dart';
import 'package:corona_tracker/views/questionnaire.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_tracker/views/Fichierep.dart';
var email;
var home;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   email = await FlutterSession().get("email");

  /*await CountryCodes.init();*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static Widget t;
  var rep;
  List<Widget> app =[
    Home(),Questionnaire(),
  Maps()
  ];
 static Widget getapp(){
    FutureBuilder<Widget>(
        future: getRep(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot1) {
          if (snapshot1.hasData) {
            home= snapshot1.data;
            return home;
          }
          else{
            home= Center(
                child: CircularProgressIndicator()

            );
          return home;
          }});
    return home;
  }
  static Future<Widget> getRep() async{
    dynamic email = await FlutterSession().get("email");
    Firestore.instance
        .collection('users')
        .getDocuments().then((QuerySnapshot querySnapshot) {
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.documents.forEach((DocumentSnapshot result) {
        if (result.data['email'] == email) {
          if (result.data['Reponse'] == true) {
            t = Fichierep();
          }
          else {
            t = Questionnaire();
          }
        }
      });
    });
    return t;

  }
  deconnecter() async{
    dynamic email = await FlutterSession().get("email");
    email = null;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              deconnecter();
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body:app[currentIndex],

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),

          BottomNavyBarItem(
            icon: Icon(Icons.list),
            title: Text("Test covid 19"
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.location_on),
            title: Text('Location'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
