import 'package:corona_tracker/views/ForgetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/views/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/password.dart';
import 'package:corona_tracker/main.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
 FirebaseAuth _auth=FirebaseAuth.instance;
  Future<void> setSession() async{
      await storage.write(key: "email", value: _email.text.trimRight());
  }
 void validate(BuildContext context) async {
  if (_formKey.currentState.validate()) {
   setState(() {
    visible = true;
   });
   var _authenticatedUser = await _auth.signInWithEmailAndPassword(
       email: _email.text.trimRight(),
       password: _pass.text).catchError((err) =>

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
   if (_authenticatedUser.uid != null) {
    setState(() {
     visible = false;
    });
    if (_authenticatedUser.isEmailVerified) {
     setSession();
     await storage.write(key: "uid", value:_authenticatedUser.uid);
     MyHomePage.currentIndex=0;
     Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
      ModalRoute.withName("homePage"),
     );
    } else {
     showDialog<void>(
      context: context,
      builder: (BuildContext context) {
       return AlertDialog(
        title: Text('Warning'),
        content: const Text('Please valid your account'),
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
     );
    }
   } else {

   }
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
   var width= MediaQuery.of(context).size.width;
   var height=MediaQuery.of(context).size.height;
  return Scaffold(
     body: ModalProgressHUD(
      inAsyncCall: visible,
      color: backgroundColor,
       child:SafeArea(
         child:Padding(
         padding:  EdgeInsets.only(top:height/20),
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
     SizedBox(height: height/8),
     Form(
     key: _formKey,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
    border: UnderlineInputBorder()),
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
          SizedBox(height: height/20),

     InkWell(
   onTap: () {
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
   child: const Text('Login', style: TextStyle(fontSize: 15)),
   ),

    ),


   ),
     SizedBox(
      height: height/40,
     ),
     Center(
      child : GestureDetector(
       onTap: () {
        Navigator.push(
         context,
         MaterialPageRoute(
             builder: (context) => ForgetPass()),
        );
       },
       child: Text(
        "Reset Password",
        style: TextStyle(
         decoration: TextDecoration.underline,
         color: Colors.blue,
        ),
       ),
      ),
     )
    ] ),

    ),
    ]),

     )


    )

    )

    ));
  }
}
