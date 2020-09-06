import 'package:corona_tracker/classes/Notif.dart';
import 'package:corona_tracker/views/Login.dart';
import 'package:corona_tracker/views/Maps.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/views/Home.dart';
import 'package:corona_tracker/views/notificationView.dart';
import 'package:corona_tracker/views/bottom_navy_bar.dart';
import 'package:corona_tracker/views/questionnaire.dart';
import 'package:corona_tracker/views/splashScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_tracker/views/Fichierep.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart' ;
var email;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
      home:SplashScreen(),

    );
  }
}

class MyHomePage extends StatefulWidget {
 static int currentIndex=0;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static Widget fichierQuest;
  DateTime backbuttonpressedTime;
  final storage = new FlutterSecureStorage();
  static  Widget r;
  static var fichie;
  static String resultEmail;
Notif notiiiiif =new Notif();
  static var uid;
  //list widget for bottom navigation

  Future<void> deconnecter() async{
    await storage.deleteAll().then((value) =>
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login()
            ),
            ModalRoute.withName("login"))
    );
  }
  Future<String> getEmail() async{
    return await storage.read(key: 'uid');
  }
  static  Future<Widget> getRep1(String uid) async {
    try {
      Firestore.instance
          .collection('users')
          .document(uid).get().then((DocumentSnapshot snapshot) async {
        if (snapshot.data["Reponse"] == true) {
          r = Fichierep();
        }
        else
          r = Questionnaire();
      });
      await Future<Widget>.delayed(const Duration(seconds: 2));
      return r;
    }
    catch (e) {
      print(e);
    }
  }
    List<Widget> app = [
      Home(), FutureBuilder<Widget>(
          future: getRep1(resultEmail),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(
                    child: Text("Loading..."));
              default :
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else {
                  if (snapshot.hasData) {
                    return snapshot.data;
                  }
                }
                break;
            }
            return null;
          }),
      Shownotification(), Maps()
    ];

    String title;
    String getName(int index) {
      if (index == 0 || index == 3) {
        title = app[index].toString();
      }
      else if (index == 2) {
        title = "Notifications";
      }
      else {
        title = "Test covid-19";
      }
      return title;
    }

    getMalade(uid){
      var dn = Firestore.instance
          .collection('users')
          .document(uid).get().then((DocumentSnapshot snapshot) async {
        return await storage.write(key: "malade", value: snapshot.data["malade"]);
      });
    }
  Future<String> readSession() async{
    String  value = await storage.read(key: "email");
    return value;
  }
  String valueNew;
  @override
  void initState() {
    // TODO: implement initState

    FutureBuilder(
        future:readSession(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                  child:Text("Loading..."));
            default :
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else {
                if (snapshot.hasData) {
                  setState(() {
                    valueNew = snapshot.data;
                  });
                }
                return null;
              }}}
    );
    getEmail().then(( value) =>
        setState(() {
          uid=value;
          getRep1(value);
          getMalade(value);
        }));
    notiiiiif.initNotifications(context);
    super.initState();
  }


  GlobalKey navBarGlobalKey = GlobalKey(debugLabel: 'bottomAppBar');
  int currentIndex=MyHomePage.currentIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(getName(currentIndex)),
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
          onItemSelected: (index) =>
              setState(() {
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
              icon: Icon(Icons.notification_important),
              title:  Text("Notification"),
              activeColor: Colors.deepOrange,
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

      ),

    );

  }


}