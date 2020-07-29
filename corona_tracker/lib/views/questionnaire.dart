
import 'package:corona_tracker/classes/Ip_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class Questionnaire extends StatefulWidget {
  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  // omitted

  final TextEditingController _age = TextEditingController();
  final TextEditingController _height= TextEditingController();
  final TextEditingController _weight = TextEditingController();
  int _currentStep = 0;
  String selectedRadio;
String selectedRadio1;
  String selectedRadio2;
  String selectedRadio3;
  String selectedRadio4;
  bool _autoValidate = false;
  final firestoreInstance = Firestore.instance;
  @override
  void initState() {
    super.initState();
    selectedRadio = null;
    selectedRadio1 = null;
    selectedRadio2 = null;
   selectedRadio3=null;
   selectedRadio4=null;
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
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.white,

        body:Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
        child:SafeArea(
              child: Stepper(

          steps: _mySteps(),
        currentStep: this._currentStep,
        onStepTapped: (step){
          setState(() {
            this._currentStep = step;
          });
        },

        onStepContinue: (){
          setState(() {
            if(this._currentStep >=0 && !(this._currentStep>=1) ){
              this._currentStep = this._currentStep + 1;
            }
            else{
              //Logic to check if everything is completed
              Response(context);
              validateAnswers(context);
            }
          });

        },

        onStepCancel: () {
          setState(() {
            if(this._currentStep > 0) {
              this._currentStep = this._currentStep - 1;
            }else{
              this._currentStep = 0;
            }
          });
        },

      ),
    )));
  }

  List<Step> _mySteps() {
    autovalidate: _autoValidate;
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
                      value:"no",
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
                      value:"no",
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
  int CountSelect(BuildContext context){
    int count=0;
    for(int i=0;i<6;i++){

        }
  }
Future<void> Response(BuildContext context) async{
    dynamic email=await FlutterSession().get("email");
    print(email);

    var data = Firestore.instance

      .collection('questionnaire')
      .getDocuments().then((querySnapshot)
  {
    firestoreInstance.collection("questionnaire").add(
        {
          "Age":_age.text,
          "Height":_height.text,
          "Weight":_weight.text,
          "R1": selectedRadio,
          "R2": selectedRadio1,
          "R3":selectedRadio2,
          "R4": selectedRadio3,
          "R5":selectedRadio4,
          "email":email
        }
    ).then((_) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Done'),
            content: const Text('Welcome to corona tracker'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Questionnaire()),
                  );
                },
              ),
            ],
          );
        },
      );
    });


  });
   /* var data1 = Firestore.instance

        .collection('users')
        .document(email).updateData("Response":true);*/

}
  Future<void> validateAnswers(BuildContext context) {
    if (selectedRadio == 1 && selectedRadio1 == 1 &&
        selectedRadio2 == 1 && selectedRadio3 == 1 &&
        selectedRadio4 == 1) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Warning'),
            content: const Text('you should do test coronavirus'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  selectedRadio=null;
                  selectedRadio1=null;
                  selectedRadio2=null;
                  selectedRadio3=null;
                  selectedRadio4=null;

                  Navigator.of(context).pop();
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
                    selectedRadio=null;
                    selectedRadio1=null;
                    selectedRadio2=null;
                    selectedRadio3=null;
                    selectedRadio4=null;

                    Navigator.of(context).pop();


                    },
                ),
              ],
            );
          }
      );
    }
  }

}



