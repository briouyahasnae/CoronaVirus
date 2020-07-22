import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/views/signup.dart';

final backgroundColor=const Color(0xFFf4f4f6);

class Login extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

     body: Container(
       color: backgroundColor,
       height: MediaQuery.of(context).size.height,
       width: MediaQuery.of(context).size.width,
       child:SafeArea(




    child:Padding(
    padding: const EdgeInsets.only(top:20),
    child: SafeArea(
    key: _formKey,
    child:ListView(

    children: <Widget>[
    Align(
    alignment: Alignment.center,
   child:Row(

    children: <Widget>[

     GestureDetector(
      onTap: () {
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Signup()),
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
    child:Padding(
    padding: const EdgeInsets.only(top:70),

    child: Column(

    children: <Widget>[

    TextFormField(
    style: TextStyle(color: const Color(0xFF272343)),
    validator: (value) {
    if (value.isEmpty) {
    return 'Please enter some text';
    }
    return null;
    },
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
    validator: (value) {
    if (value.isEmpty) {
    return 'Please enter some text';
    }
    return null;
    },
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
    // Validate returns true if the form is valid, otherwise false.
    if (_formKey.currentState.validate()) {
    // If the form is valid, display a snackbar. In the real world,
    // you'd often call a server or save the information in a database.

    Scaffold
        .of(context)
        .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
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
