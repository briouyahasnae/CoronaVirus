import 'package:corona_tracker/views/DestinationView.dart';
import 'package:corona_tracker/views/Login.dart';
import 'package:corona_tracker/views/Maps.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/views/Home.dart';
import 'package:corona_tracker/views/bottom_navy_bar.dart';
import 'package:corona_tracker/views/questionnaire.dart';

import 'package:flutter_session/flutter_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_tracker/views/Fichierep.dart';
import 'package:http/http.dart';
var email;
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

  int currentIndex = 0;

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   static  Widget r;
   static Widget t;


   //list widget for bottom navigation

  List<Widget> app =[
    Home(),FutureBuilder(

      future: getRep1(),
      builder: (BuildContext context,AsyncSnapshot<Widget> snapshot){

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
   return snapshot.data;
   }
   }
   break;

   }
      return null;
      }),
  Maps()
  ];


 void deconnecter(BuildContext context) async{
   dynamic email = await FlutterSession().get("email");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>Login()));
  }


  static Future<Widget> getRep1() async {
     dynamic email = await FlutterSession().get("email");

   var dn=  Firestore.instance
         .collection('users')
         .getDocuments();
   dn.then((querySnapshot) {
       querySnapshot.documents.forEach((result) {

         if (result.data['email'] == email) {
           if(result.data['Reponse']==true) {

            r=Fichierep();
           }
             else
             r=Questionnaire();

           }
       });
    });
   await Future<Widget>.delayed(const Duration(seconds: 2));
return r;


   }

@override
void initState() {

    // TODO: implement initState
    super.initState();
    getRep1().then((result){
      print("result $result");
      setState(() {
        t=result;
      });

    });
      print(t);
  }
   int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app[currentIndex].toString()),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              deconnecter(context);
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
