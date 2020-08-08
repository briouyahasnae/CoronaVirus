import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/views/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/password.dart';
import 'package:corona_tracker/views/Home.dart';
import 'package:corona_tracker/main.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

final backgroundColor=const Color(0xFFf4f4f6);
bool visible=false;
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {
 final storage = new FlutterSecureStorage();
 final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _email = TextEditingController();
  Future<void> setSession() async{
      await storage.write(key: "email", value: _email.text.trimRight());
  }
  void validate(BuildContext context)  {
   int count = 0;
   if (_formKey.currentState.validate()) {
    setState(() {
     visible=true;
    });
       Firestore.instance
        .collection('users')
        .getDocuments().then((querySnapshot) async {
     querySnapshot.documents.forEach((result) {
      if (result.data['email'] == _email.text.trimRight() &&
          result.data['password'] == Password.hash(_pass.text, new PBKDF2())
              .toString()) {
       count++;
      }
     });
    switch(count){
     case 0:
      setState(() {
       visible=false;
      });
      return showDialog<void>(
       context: context,
       builder: (BuildContext context) {
        return AlertDialog(
         title: Text('Warning'),
         content: const Text('Verifie your email or password'),
         actions: <Widget>[
          FlatButton(
           child: Text('Ok'),
           onPressed: () {
            Navigator.of(context).pop();
           },
          ),
         ],
        );
       },
      );
     break;
     default:
      setState(() {
        visible=false;
      });
     setSession();
      Navigator.pushAndRemoveUntil(
       context,
       MaterialPageRoute(builder: (context) => MyHomePage()),
       ModalRoute.withName("homePage"),
      );
      break;
     }
    });
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
  @override
  Widget build(BuildContext context) {
  return Scaffold(

     body: ModalProgressHUD(
      inAsyncCall: visible,
      color: backgroundColor,

       child:SafeArea(




    child:Padding(
    padding: const EdgeInsets.only(top:20),
    child: SafeArea(
    child:ListView(

    children: <Widget>[
    Align(
    alignment: Alignment.center,
   child:Row(

    children: <Widget>[

     GestureDetector(
      onTap: () {
       Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Signup()),
       ModalRoute.withName("signup"),
       );
      },

      child:  Icon(
       Icons.arrow_back,
       color: Colors.blue,
       size: 24.0,
      ),
     ),
    Text(
    "      Sign in to your account",

    style:TextStyle(
    color:const Color(0xFF272343),
    fontSize:20,
    decoration : null,
    fontWeight: FontWeight.bold,

    )
    ),
    ]
       ),
     ),
    Form(
     key: _formKey,
    child:Padding(
    padding: const EdgeInsets.only(top:70),

    child: Column(

    children: <Widget>[

    TextFormField(
    style: TextStyle(color: const Color(0xFF272343)),
     maxLines: 1,
    controller: _email,
     validator: (value)=>validateEmail(value.trimRight()),

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
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    keyboardType: TextInputType.emailAddress,
    ),
    TextFormField(
    style: TextStyle(color: const Color(0xFF272343)),
    controller: _pass,
     validator: (value)=>value.isEmpty?"Password can\'t be empty":null,
     obscureText: true,
    decoration: new InputDecoration(
    labelText: 'Enter your Password',
    enabledBorder: UnderlineInputBorder(
    borderSide:
    BorderSide(color: Colors.grey),
    ),
    focusedBorder: UnderlineInputBorder(
    borderSide:
    BorderSide(color: Colors.amber),
    ),
    border: UnderlineInputBorder()),
    ),

    Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: RaisedButton(
    onPressed: () {
     validate(context);
     // stop the Progress indicator after 5 seconds
    },
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
    child:
    Align(
    alignment: Alignment.center,
    child: const Text('Login', style: TextStyle(fontSize: 15)),
    ),
    )


    ),


    ),
    ]
    ),
    ),
    )


    ]
    )

    )

    ),
    ),
    ),
    );
  }
}
