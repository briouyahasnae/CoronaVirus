import 'dart:core';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/views/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/password.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';

final backgroundColor = const Color(0xFFf4f4f6);

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  DateTime backbuttonpressedTime;

  bool _isLoading;
 bool visible=false;
  @override
  void initState() {
    _isLoading = true;
    super.initState();
  }


  var countries;
  final firestoreInstance = Firestore.instance;
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  /*String _value;
  Future<List<Country>> getCountries() async {
    return countries= await  CountryProvider.getAllCountries();

  }*/
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    //Statement 1 Or statement2
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);
    if (backButton) {
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
          msg: "Double Click to exit app",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return false;
    }
    return true;
  }

  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  Future<void> validate(BuildContext context) async {
    if (formKey.currentState.validate()) {
      setState(() {
        visible=true;
      });
      FirebaseUser user = await _firebaseAuth
          .createUserWithEmailAndPassword(email: _email.text.trimRight(),
          password:_pass.text).catchError((err)=>
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Warning'),
                content: Text(err.message),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        visible = false;
                      });
                    },
                  ),
                ],
              );
            },
          ));
      FirebaseUser userid = await _firebaseAuth.currentUser();

      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = _username.text;
      userid.updateProfile(updateInfo);
      try {
        await user.sendEmailVerification();
        firestoreInstance.collection("users").document(userid.uid).setData({
          "Reponse": false,
          "malade": false,
          "x": null,
          "y": null
        }).then((_) {
          setState(() {
            visible = false;
          });

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
          return CircularProgressIndicator();
        });
        return user.uid;
      } catch (e) {
        print(
            "An error occured while trying to send email        verification");
        print(e.message);
      }
    } else {
      return Text("form is invalid");
    }
  }
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
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: visible,
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.only(top: height/20),
          child: SafeArea(
              child: Center(
                  child: ListView(children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text("Sign up to track corona virus",
                  style: TextStyle(
                    color: const Color(0xFF272343),
                    fontSize: 20,
                    decoration: null,
                    fontWeight: FontWeight.bold,
                  )),
            ),
           SizedBox(height: height/15),
            Form(
              key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  TextFormField(
                    style: TextStyle(color: const Color(0xFF272343)),
                    validator: (value) =>
                        value.isEmpty ? "Username can\'t be empty" : null,
                    controller: _username,
                    decoration: new InputDecoration(
                        labelText: 'Enter your Username',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        border: UnderlineInputBorder()),
                  ),
                  TextFormField(
                    style: TextStyle(color: const Color(0xFF272343)),
                    validator: (value) =>
                        validateEmail(value.trimRight()),
                    controller: _email,
                    decoration: new InputDecoration(
                        labelText: 'Enter your Email',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        border: UnderlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    style: TextStyle(color: const Color(0xFF272343)),
                    controller: _pass,
                    validator: (value) {
                      Pattern pattern =
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
                      RegExp regex = new RegExp(pattern);
                      if (value.length <= 7) {
                        return "Password can\'t be less than 8 caractere";
                      } else {
                        if (!regex.hasMatch(value))
                          return 'Uppercase and lowercase ,numbers are required';
                        else
                          return null;
                      }
                    },
                    obscureText: true,
                    decoration: new InputDecoration(
                        labelText: 'Enter your Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        border: UnderlineInputBorder()),
                  ),
                  TextFormField(
                    style: TextStyle(color: const Color(0xFF272343)),
                    controller: _confirmPass,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Password can\'t be empty";
                      }
                      if (value != _pass.text) {
                        return "Verifie your password";
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                        labelText: 'Confirm your password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        border: UnderlineInputBorder()),
                  ),

                  /* FutureBuilder<List<Country>>(
                 future: getCountries(),
                 builder: (context, snapshot) {
                   if (snapshot.connectionState != ConnectionState.done) {
                     // return: show loading widget
                   }
                   if (snapshot.hasError) {
                     // return: show error widget
                   }
                   List<Country> users = snapshot.data ?? [];

                   return  DropdownButtonFormField<dynamic>(
                     isDense: false,
                     isExpanded: true,
                     hint: new Text("Select Country"),
                     value: _value ,
                     items: users.map((var value) {
                       return new DropdownMenuItem<dynamic>(
                         value: value.name,
                         child: new Text(value.name),

                       );
                     }).toList(),
                     onChanged: (value) {
                       setState(() {
                        _value=value;
                       });
                     },
                     validator: (value) {
                       if (value?.isEmpty ?? true) {
                         return 'Please enter a valid Country';
                       }
                       return null;
                     },
                   );
                 }),*/
                      SizedBox(height: height/20),
                      RaisedButton(
                        onPressed: () {
                          validate(context);
                        },
                        // Validate returns true if the form is valid, otherwise false.
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
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
                          child: Align(
                            alignment: Alignment.center,
                            child: const Text('Submit',
                                style: TextStyle(fontSize: 15)),
                          ),
                        )),
                      SizedBox(height: height/25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                      Text("if you already have an account"),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                            ModalRoute.withName("login"),
                          );
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ]),
                  ]),
            )]),
              ),
            )
          ))
        );
  }
}
