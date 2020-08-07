
import 'package:corona_tracker/classes/Ip_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:corona_tracker/views/DestinationView.dart';
import 'package:geolocator/geolocator.dart';

class Questionnaire extends StatefulWidget {
  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  // omitted

  final TextEditingController _age = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  int _currentStep = 0;
  String selectedRadio;
  String selectedRadio1;
  String selectedRadio2;
  String selectedRadio3;
  String selectedRadio4;
  bool _autoValidate = false;
  final firestoreInstance = Firestore.instance;
Position _currentPosition;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();




  void _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
         _currentPosition = position;
      });
      print("x ${_currentPosition.latitude}");
      print("y ${_currentPosition.longitude}");
    }).catchError((e) {
      print(e);
    });
  }
// Changes the selected value on 'onChanged' click on each radio button
  void setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void setSelectedRadio1(String val) {
    setState(() {
      selectedRadio1 = val;
    });
  }

  void setSelectedRadio2(String val) {
    setState(() {
      selectedRadio2 = val;
    });
  }

  void setSelectedRadio3(String val) {
    setState(() {
      selectedRadio3 = val;
    });
  }

  void setSelectedRadio4(String val) {
    setState(() {
      selectedRadio4 = val;
    });
  }
  void pasStep(int step){
    setState(() {
      if (this._currentStep >= 0 && !(this._currentStep >= 1)) {
        print("age ${_age.text}");
        if (_age.text != '' && _weight.text != '' && _height.text != '') {
          this._currentStep = this._currentStep + 1;
        }
      }

      if (this._currentStep >= 1) {
        this._currentStep = step;
      }
    });

  }
 void _onTapMalade() async {

   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
       'your channel id', 'your channel name', 'your channel description',
       importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
   var platformChannelSpecifics = NotificationDetails(
       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
   await flutterLocalNotificationsPlugin.show(
       0, 'result test', 'you should do corona test', platformChannelSpecifics,
       payload: 'item x');
 print('hi');
  }
  Future<void> _initNotifications() async{

    var initializationSettingsAndroid = new AndroidInitializationSettings('logo');
    print(initializationSettingsAndroid );
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: (i, string1, string2, string3) {
          print("received notifications");
        });
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (string) {
          print("selected notification");
        });

  }
  @override
  void initState() {
    print("Initialize 1");
    _initNotifications();
    super.initState();
    selectedRadio = null;
    selectedRadio1 = null;
    selectedRadio2 = null;
    selectedRadio3 = null;
    selectedRadio4 = null;
    _getCurrentLocation();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,

        body: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: SafeArea(
              child: Stepper(

                steps: _mySteps(),
                currentStep: this._currentStep,
                onStepTapped: (step) {

                  pasStep(step);
                },

                onStepContinue: () {
                  setState(() {
                    if (this._currentStep >= 0 && !(this._currentStep>=1)) {
                      print("age ${_age.text}");
                      if(_age.text !='' && _weight.text !='' && _height.text!='' ){
                        this._currentStep = this._currentStep + 1;
                      }

                    }
                    else if(this._currentStep>=1) {
                      //Logic to check if everything is completed
                      if (selectedRadio != null && selectedRadio1 != null &&
                          selectedRadio2 != null && selectedRadio3 != null &&
                          selectedRadio4 != null) {
                        Response(context);
                        validateAnswers(context);

                      }
                    }
                  });
                },

                onStepCancel: () {
                  setState(() {
                    if (this._currentStep > 0) {
                      this._currentStep = this._currentStep - 1;
                    } else {
                      this._currentStep = 0;
                    }
                  });
                },
                controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _currentStep == 4 // this is the last step
                            ?
                        RaisedButton.icon(
                          icon: Icon(Icons.create),

                          label: Text('CREATE'),
                          color: Colors.green,
                        )
                            : RaisedButton.icon(
                          icon: Icon(Icons.navigate_next),
                          onPressed: onStepContinue,
                          label: Text('CONTINUE'),
                          color: Colors.pink,
                        ),
                        FlatButton.icon(
                          icon: Icon(Icons.delete_forever),
                          label: const Text('CANCEL'),
                          onPressed: onStepCancel,
                        )
                      ],
                    ),
                  );
                },


              ),
            )));


  }

  List<Step> _mySteps() {
    autovalidate:
    _autoValidate;
    List<Step> _steps = [
      Step(
        title: Text('Personal informations'),

        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              controller: _age,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Height'),
              keyboardType: TextInputType.number,
              controller: _height,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
              controller: _weight,
            ),
          ],
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Symptoms'),
        content: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Row(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text(
                      'new or worsening cough :',
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.bold),
                    ),

                    Radio(
                      value: "yes",
                      groupValue: selectedRadio1,
                      activeColor: Colors.green,
                      onChanged: (val1) {
                        print("Radio $val1");
                        setSelectedRadio1(val1);
                      },
                    ),
                    Text('Yes'),
                    Radio(
                      value: "no",
                      groupValue: selectedRadio1,
                      activeColor: Colors.blue,
                      onChanged: (val1) {
                        print("Radio $val1");
                        setSelectedRadio1(val1);
                      },
                    ),
                    Text('No'),
                  ]),
              Row(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text(
                      'difficulty breathing :',
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.bold),
                    ),

                    Radio(
                      value: "yes",
                      groupValue: selectedRadio,
                      activeColor: Colors.green,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio(val);
                      },
                    ),
                    Text('Yes'),
                    Radio(
                      value: "no",
                      groupValue: selectedRadio,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio(val);
                      },
                    ),
                    Text('No'),

                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text(
                      'new loss of smell or taste:',
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.bold),
                    ),

                    Radio(
                      value: "yes",
                      groupValue: selectedRadio2,
                      activeColor: Colors.green,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio2(val);
                      },
                    ),
                    Text('Yes'),
                    Radio(
                      value: "no",
                      groupValue: selectedRadio2,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio2(val);
                      },
                    ),
                    Text('No'),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text(
                      'fatigue or weakness:',
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.bold),
                    ),

                    Radio(
                      value: "yes",
                      groupValue: selectedRadio3,
                      activeColor: Colors.green,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio3(val);
                      },
                    ),
                    Text('Yes'),
                    Radio(
                      value: "no",
                      groupValue: selectedRadio3,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio3(val);
                      },
                    ),
                    Text('No'),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text('temperature >= 38°C :',
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.bold),
                    ),

                    Radio(
                      value: "yes",
                      groupValue: selectedRadio4,
                      activeColor: Colors.green,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio4(val);
                      },
                    ),
                    Text('Yes'),
                    Radio(
                      value: "no",
                      groupValue: selectedRadio4,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio4(val);
                      },
                    ),
                    Text('No'),
                  ]),
            ]),

        isActive: _currentStep >= 1,
      ),

    ];

    return _steps;
  }


  Future<void> Response(BuildContext context) async {
    dynamic email = await FlutterSession().get("email");
    print(email);

    var data = Firestore.instance

        .collection('questionnaire')
        .getDocuments().then((querySnapshot) {
      firestoreInstance.collection("questionnaire").add(
          {
            "Age": _age.text,
            "Height": _height.text,
            "Weight": _weight.text,
            "R1": selectedRadio,
            "R2": selectedRadio1,
            "R3": selectedRadio2,
            "R4": selectedRadio3,
            "R5": selectedRadio4,
            "email": email
          });


    });
    var data1 = Firestore.instance
        .collection('users')
        .getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        if (result.data['email'] == email) {
          result.reference.updateData(<String,dynamic>{
            "Reponse" : true,

          });
        };
      });
  });
        }
  Future<void> updateMalade(BuildContext context) async{
    dynamic email = await FlutterSession().get("email");
          Firestore.instance
        .collection('users')
        .getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        if (result.data['email'] == email) {

          result.reference.updateData(<String,dynamic>{
            "malade" : true,
            "x":_currentPosition.latitude,
            "y":_currentPosition.longitude
          });
        }
      });
    });
  }

   /* var data1 = Firestore.instance

        .collection('users')
        .document(email).updateData("Response":true);*/

    Future<void> validateAnswers(BuildContext context) {
    int count=0;
    if (selectedRadio=="yes") {
        count++;
      }
    if (selectedRadio1=="yes") {
        count++;
      }
    if (selectedRadio2=="yes") {
      count++;
    }
    if (selectedRadio4=="yes") {
      count++;
    }
    if (selectedRadio3=="yes") {
      count++;
    }
    print(count);
    if(count >=3){
_onTapMalade();
      updateMalade(context);
        return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Warning'),
              content: const Text('you should do test coronavirus'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () async {
                    selectedRadio = null;
                    selectedRadio1 = null;
                    selectedRadio2 = null;
                    selectedRadio3 = null;
                    selectedRadio4 = null;


                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DestinationView()),
                    );
                  },
                ),
              ],
            );
          },
        );
      }
      else {
        return showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Warning'),
                content: const Text('You are okay'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      selectedRadio = null;
                      selectedRadio1 = null;
                      selectedRadio2 = null;
                      selectedRadio3 = null;
                      selectedRadio4 = null;

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>DestinationView()),
                      );
                    },
                  ),
                ],
              );
            }
        );
      }
    }
  }




