import 'package:flutter/material.dart';

class Questionnaire extends StatefulWidget {
  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  // omitted


  int _currentStep = 0;
  int selectedRadio;
int selectedRadio1;
int selectedRadio2;
  int selectedRadio3;
  int selectedRadio4;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadio1 = 0;
    selectedRadio2 = 0;
   selectedRadio3=0;
   selectedRadio4=0;
  }

// Changes the selected value on 'onChanged' click on each radio button
 void setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }
  void setSelectedRadio1(int val) {
    setState(() {
      selectedRadio1 = val;
    });


  }
  void setSelectedRadio2(int val) {
    setState(() {
      selectedRadio2 = val;
    });
  }
  void setSelectedRadio3(int val) {
    setState(() {
      selectedRadio3 = val;
    });
  }
  void setSelectedRadio4(int val) {
    setState(() {
      selectedRadio4 = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title: Text("Questionnaire"),
      ),
      body: Stepper(
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
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text('Personal informations'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Height'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
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
                      value: 1,
                      groupValue: selectedRadio1,
                      activeColor: Colors.green,
                      onChanged: (int val1) {
                        print("Radio $val1");
                        setSelectedRadio1(val1);
                      },
                    ),
                    Text('Yes'),
                    Radio(
                      value: 2,
                      groupValue: selectedRadio1,
                      activeColor: Colors.blue,
                      onChanged: (int val1) {
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
                      value: 1,
                      groupValue: selectedRadio,
                      activeColor: Colors.green,
                      onChanged: (int val) {
                        print("Radio $val");
                        setSelectedRadio(val);
                      },
                    ),
                    Text('Yes'),
                    Radio(
                      value: 2,
                      groupValue: selectedRadio,
                      activeColor: Colors.blue,
                      onChanged: (int val) {
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
                      value: 1,
                      groupValue: selectedRadio2,
                      activeColor: Colors.green,
                      onChanged: (int val) {
                        print("Radio $val");
                        setSelectedRadio2(val);
                      },
                    ),
                    Text('Yes'),
                    Radio(
                      value: 2,
                      groupValue: selectedRadio2,
                      activeColor: Colors.blue,
                      onChanged: (int val) {
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
                      value: 1,
                      groupValue: selectedRadio3,
                      activeColor: Colors.green,
                      onChanged: (int val) {
                        print("Radio $val");
                        setSelectedRadio3(val);
                      },
                    ),
                    Text('Yes'),
                    Radio(
                      value: 2,
                      groupValue: selectedRadio3,
                      activeColor: Colors.blue,
                      onChanged: (int val) {
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
                      value: 1,
                      groupValue: selectedRadio4,
                      activeColor: Colors.green,
                      onChanged: (int val) {
                        print("Radio $val");
                        setSelectedRadio4(val);
                      },
                    ),
                    Text('Yes'),
                    Radio(
                      value: 2,
                      groupValue: selectedRadio4,
                      activeColor: Colors.blue,
                      onChanged: (int val) {
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



