import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:corona_tracker/classes/Notif.dart';
import 'package:corona_tracker/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mailer2/mailer.dart';
class Questionnaire extends StatefulWidget {
  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  // omitted
  final MyHomePage homee=new MyHomePage();
  final Notif notification=new Notif();

  GlobalKey<FormState> _formKey =  GlobalKey<FormState>();
  List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];
  final storage = new FlutterSecureStorage();
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
    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;

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

  void pasStep(int step) {
    setState(() {
      if (this._currentStep >= 0 && !(this._currentStep >= 1)) {
        print("age ${_age.text}");
        if(formKeys[_currentStep].currentState.validate()) {
          if (_age.text != '' && _weight.text != '' && _height.text != '') {
            this._currentStep = this._currentStep + 1;
          }
        }
      }

      if (this._currentStep >= 1) {
        this._currentStep = step;
      }
    });

  }
dynamic sendEmail() async{
  dynamic email = await storage.read(key: "email");
  var options = new GmailSmtpOptions()
    ..username = 'assmaesafae20@gmail.com'
    ..password = 'marwaasmae06111998'; // Note: if you have Google's "app specific passwords" enabled,
  // you need to use one of those here.

  // How you use and store passwords is up to you. Beware of storing passwords in plain.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'assmaesafae20@gmail.com'
    ..recipients.add(email.toString())
    ..subject = 'Test covid 19'
    ..text = 'You had better do test covid -19'
    ..html = 'Your answers to covid-19 <br> age: ${_age.text} <br> weight : ${_weight.text} <br> height:${_height.text}<br> new or worsening cough:$selectedRadio <br> difficulty breathing:$selectedRadio1'+
    '<br> new loss of smell or taste $selectedRadio2 <br> fatigue or weakness :$selectedRadio3 <br> temperature plus 38 :$selectedRadio4 <br> <strong> YOU HAD BETTER TO DO TEST COVID-19</strong>';

  // Email it.
  emailTransport.send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}


  @override
  void initState() {
    print("Initialize 1");

    selectedRadio = null;
    selectedRadio1 = null;
    selectedRadio2 = null;
    selectedRadio3 = null;
    selectedRadio4 = null;
    _getCurrentLocation();
    setState(() {
      MyHomePage.currentIndex=1;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


   var height= MediaQuery

        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
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
                child:  Form(
                  key: _formKey,
                  child:  ListView(
                      children: <Widget>[
                 Stepper(
                  steps: _mySteps(),

                  currentStep: this._currentStep,
                  onStepTapped: (step) {
                    pasStep(step);
                  },

                  onStepContinue: () {
                    setState(() {
                      if(formKeys[_currentStep].currentState.validate()){
                        if (this._currentStep >= 0 && !(this._currentStep >=
                            1)) {
                          print("age ${_age.text}");
                          if (_age.text != '' && _weight.text != '' &&
                              _height.text != '') {
                            if(_formKey.currentState.validate()) {
                            this._currentStep = this._currentStep + 1;
                            }
                          }
                        }
                        else if (this._currentStep >= 1) {
                          //Logic to check if everything is completed
                          if (selectedRadio != null && selectedRadio1 != null &&
                              selectedRadio2 != null &&
                              selectedRadio3 != null &&
                              selectedRadio4 != null) {
                            Response(context);
                            validateAnswers(context);
                          }
                          else{
                           showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Icon(Icons.warning,color: Colors.red,size:30,),
                                      content: const Text('Please complete all questions'),
                                      actions: <Widget>[
                                  FlatButton(
                                  child: Text('Ok'),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  }),]
                                      );}
                            );}
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

                        _age.clear();
                        _height.clear();
                        _weight.clear();
                      }
                    });
                  },

                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _currentStep == 4 // this is the last step
                              ?
                          ButtonTheme(
                              minWidth: width / 10,
                              height: height / 10,
                              child: RaisedButton.icon(
                                icon: Icon(Icons.create),
                                label: Text('CREATE'),
                                color: Colors.green,
                                onPressed: () {},

                              ))
                              :
                          Flexible(

                              child: ButtonTheme(
                                  height: height / 15,
                                  child: RaisedButton.icon(
                                    icon: Icon(Icons.navigate_next),
                                    onPressed: onStepContinue,
                                    label: Flexible(child: Text('CONTINUE',
                                        style: TextStyle(fontSize: 11))),
                                    color: Colors.pink,
                                  ))),
                          Flexible(
                              child: ButtonTheme(
                                  height: height / 15,
                                  child:
                                  FlatButton.icon(
                                    icon: Icon(Icons.delete_forever),
                                    label: Text('CANCEL',
                                      style: TextStyle(fontSize: 11),),
                                    onPressed: onStepCancel,
                                  )
                              ))
                        ],
                      ),
                    );
                  },


                )])))));
  }


  List<Step> _mySteps() {
    List<Step> _steps = [

      Step(
        title: Text('Personal informations'),
          state: StepState.indexed,
      // state: StepState.disabled,
      content:  Form(
        key: formKeys[0],
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              controller: _age,
              // ignore: missing_return
              validator: (String value) {
                if (value.isEmpty || value.length < 1) {
                  return 'Please enter age';
                }
                else if(int.parse(value)<0 || int.parse(value)>140){
                  return "Please enter a valide age";

                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Height(cm)'),
              validator: (String value) {
                if (value.isEmpty || value.length < 1) {
                  return 'Please enter height';
                }
                else if(int.parse(value)<52 || int.parse(value)>255){
                  return "Please enter a valide height";

                }
              },
              keyboardType: TextInputType.number,
              controller: _height,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Weight(kg)'),
              keyboardType: TextInputType.number,
              validator: (String value) {
                if (value.isEmpty || value.length < 1) {
                  return 'Please enter weight';
                }
                else if(double.parse(value)<=1 || double.parse(value)>500){
                  return "Please enter a valide weight";

                }
              },
              controller: _weight,
            ),
          ],
        ),

      ),
        isActive: _currentStep >= 0
      ),
      Step(
        title: Text('Symptoms'),
        state: StepState.indexed,
      content:  Form(
        key: formKeys[1],
        child: Column(

            children: <Widget>[
              Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'new or worsening cough',
                        style: TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                        child: Radio(
                          value: "yes",
                          groupValue: selectedRadio1,
                          activeColor: Colors.green,
                          onChanged: (val1) {
                            print("Radio $val1");
                            setSelectedRadio1(val1);
                          },
                        )),
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
              SizedBox(height: 10),
              Row(

                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'difficulty breathing',
                        style: TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                        child: Radio(
                          value: "yes",
                          groupValue: selectedRadio,
                          activeColor: Colors.green,
                          onChanged: (val) {
                            print("Radio $val");
                            setSelectedRadio(val);
                          },
                        )),
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
              SizedBox(height: 10),

              Row(

                  children: <Widget>[
                    Flexible(
                        child: Text(
                          'new loss of smell or taste',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.bold),
                        )),

                    Flexible(
                        child: Radio(
                          value: "yes",
                          groupValue: selectedRadio2,
                          activeColor: Colors.green,
                          onChanged: (val) {
                            print("Radio $val");
                            setSelectedRadio2(val);
                          },
                        )),
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
              SizedBox(height: 10),

              Row(
                  children: <Widget>[
                    Flexible(
                        child: Text(
                          'fatigue or weakness',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.bold),
                        )),
                    Flexible(
                        child: Radio(
                          value: "yes",
                          groupValue: selectedRadio3,
                          activeColor: Colors.green,
                          onChanged: (val) {
                            print("Radio $val");
                            setSelectedRadio3(val);
                          },
                        )),

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
              SizedBox(height: 10),
              Row(
                  children: <Widget>[
                    Flexible(
                        child: Text('temperature +38°C',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.bold),
                        )),
                    Flexible(
                        child:
                        Radio(
                          value: "yes",
                          groupValue: selectedRadio4,
                          activeColor: Colors.green,
                          onChanged: (val) {
                            print("Radio $val");
                            setSelectedRadio4(val);
                          },
                        )),
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

      ),
        isActive: _currentStep >= 1,

      ) ];

    return _steps;
  }

  Widget _smallDisplay() {
    return Column(

      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Row 1"),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Row 2"),
            ],
          ),
        )
      ],
    );
  }


  Future<void> Response(BuildContext context) async {
    var uid=await storage.read(key: "uid");
    dynamic email = await storage.read(key: "email");
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
            "email": email,
            'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch

          });
    });
    var data2 = Firestore.instance
        .collection('historiques')
        .getDocuments().then((querySnapshot) {
      firestoreInstance.collection("historiques").add(
          {
            "Age": _age.text,
            "Height": _height.text,
            "Weight": _weight.text,
            "R1": selectedRadio,
            "R2": selectedRadio1,
            "R3": selectedRadio2,
            "R4": selectedRadio3,
            "R5": selectedRadio4,
            "email": email,
            'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch

          });
    });
    var data1 = Firestore.instance
        .collection('users')
        .document(uid).updateData(<String, dynamic>{
      "Reponse": true,

    });

  }

  Future<void> updateMalade(BuildContext context) async {
    var uid=await storage.read(key: "uid");
    dynamic email = await storage.read(key: "email");

    Firestore.instance
        .collection('users')
        .document(uid).updateData(<String, dynamic>{
      "malade": true,
      "x": _currentPosition.latitude,
      "y": _currentPosition.longitude
    });
  }


/* var data1 = Firestore.instance
        .collection('users')
        .document(email).updateData("Response":true);*/

  Future<void> validateAnswers(BuildContext context) {
    int count = 0;
    if (selectedRadio == "yes") {
      count++;
    }
    if (selectedRadio1 == "yes") {
      count++;
    }
    if (selectedRadio2 == "yes") {
      count++;
    }
    if (selectedRadio4 == "yes") {
      count++;
    }
    if (selectedRadio3 == "yes") {
      count++;
    }
    print(count);
    if (count >= 3) {
      notification.onTapMalade(context);
      sendEmail();
      updateMalade(context);
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Icon(Icons.warning,color: Colors.red,size:30,),
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


                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    ModalRoute.withName("home")
                  ).then((_) => notification.onTapMalade(context));

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
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title:  Icon(Icons.done_outline,color: Colors.green,size:30,),
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

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                      ModalRoute.withName("home")
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