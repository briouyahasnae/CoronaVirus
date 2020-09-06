import 'package:corona_tracker/views/login.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final backgroundColor = const Color(0xFFf4f4f6);
  bool visible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  FirebaseAuth _auth=FirebaseAuth.instance;
//valide Email
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.length <= 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }
  //send email for verification
  validate(BuildContext context) async{
    if(_formKey.currentState.validate()){
      _auth.sendPasswordResetEmail(email: _email.text.trimRight());
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Done'),
            content: const Text('Email sent'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Login()),
                    ModalRoute.withName("login"),
                  );
                  setState(() {
                    visible=false;
                  });
                },
              ),
            ],
          );
        },
      );
    }
    else{
      return Text("form invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        appBar: AppBar(
          title: Text("Reset password"),
        ),
        body: ModalProgressHUD(
            inAsyncCall: visible,
            color: backgroundColor,
            child: SafeArea(
                child: Padding(
                    padding: EdgeInsets.only(top: height / 20),
                    child: SafeArea(
                        child: ListView(

                            children: <Widget>[
                              SizedBox(height: height / 8),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: <Widget>[

                                        TextFormField(
                                          style: TextStyle(color: const Color(
                                              0xFF272343)),
                                          maxLines: 1,
                                          controller: _email,
                                          validator: (value) =>
                                              validateEmail(value.trimRight()),

                                          decoration: new InputDecoration(
                                              labelText: 'Enter your Email',
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.grey),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.amber),
                                              ),
                                              border: UnderlineInputBorder()),
                                          keyboardType: TextInputType
                                              .emailAddress,
                                        ),
                                        SizedBox(height: height / 20),

                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              visible = true;
                                            });
                                            validate(context);
                                            // stop the Progress indicator after 5 seconds
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: <Color>[
                                                  Colors.blue,
                                                  Colors.green,
                                                  Colors.amber,
                                                ],
                                              ),
                                              borderRadius: BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),

                                            padding: const EdgeInsets.all(10.0),
                                            child:
                                            Align(
                                              alignment: Alignment.center,
                                              child: const Text('Login',
                                                  style: TextStyle(
                                                      fontSize: 15)),
                                            ),

                                          ),


                                        ),
                                      ]))
                            ]))))));
  }
}
