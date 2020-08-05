import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_tracker/views/Fichierep.dart';
import 'package:corona_tracker/views/Home.dart';
import 'package:corona_tracker/views/questionnaire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
<<<<<<< HEAD
import 'package:corona_tracker/views/Maps.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
=======
import 'bottom-navbar-bloc.dart';
>>>>>>> hasnae-dev

class DestinationView extends StatefulWidget {
  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
   BottomNavBarBloc _bottomNavBarBloc;
Widget t;
  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }
<<<<<<< HEAD
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  var home;
  int _currentIndex = 0;
=======
  Future<Widget> getRep() async{
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
           print(t.toString());
         }
           });
         });
     return t;
>>>>>>> hasnae-dev

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom NavBar Navigation'),
      ),
      body: StreamBuilder<NavBarItem>(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.HOME:
              return  Home();
            case NavBarItem.ALERT:
              return FutureBuilder<Widget>(
              future: getRep(),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot1) {
              if (snapshot1.hasData) {
                return snapshot1.data;
      }
      else{
        return Center(
        child: CircularProgressIndicator()
      );
      }
    }
              );

            case NavBarItem.SETTINGS:
              return Fichierep();
          }
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return BottomNavigationBar(
            fixedColor: Colors.blueAccent,
            currentIndex: snapshot.data.index,
            onTap: _bottomNavBarBloc.pickItem,
            items: [
              BottomNavigationBarItem(
                title: Text('Home'),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Text('Notifications'),
                icon: Icon(Icons.notifications),
              ),
              BottomNavigationBarItem(
                title: Text('Settings'),
                icon: Icon(Icons.settings),
              ),
            ],
          );
        },
      ),
    );
  }

<<<<<<< HEAD
  final List<Widget> _children = [
    Home(),
    Questionnaire(),
    Maps()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
=======
  Widget _homeArea() {
    return Center(
      child: Text(
        'Home Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.green,
          fontSize: 25.0,
        ),
      ),
    );
>>>>>>> hasnae-dev
  }

  Widget _alertArea() {
    return Center(
      child: Text(
        'Notifications Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.red,
          fontSize: 25.0,
        ),
      ),
<<<<<<< HEAD
      /* floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.fullscreen_exit),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/logout");
        },
      ),*/
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 20),
          Icon(Icons.list, size: 20),
          Icon(Icons.map, size: 20),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 800),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
=======
    );
  }

  Widget _settingsArea() {
    return Center(
      child: Text(
        'Settings Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blue,
          fontSize: 25.0,
        ),
>>>>>>> hasnae-dev
      ),
        body: Container(
          child: _children[_page]
          ),
        );
  }
}