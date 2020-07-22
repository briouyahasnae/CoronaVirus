import 'package:flutter/material.dart';
import 'package:corona_tracker/services/auth_service.dart';
import 'package:corona_tracker/views/login.dart';

final backgroundColor=const Color(0xFFf4f4f6);

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
      color: backgroundColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,


          child:Padding(
              padding: const EdgeInsets.only(top:20),
         child: SafeArea(
        key: _formKey,
        child:ListView(

          children: <Widget>[
            Align(
              alignment: Alignment.center,
            child:Text(
                "Sign up to track corona virus",
                style:TextStyle(
                  color:const Color(0xFF272343),
                  fontSize:20,
                  decoration : null,
                  fontWeight: FontWeight.bold,

                )
            ),
          ),
             Form(
               child:Padding(
                   padding: const EdgeInsets.only(top:40),

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
                     labelText: 'Enter your Username',

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
                         TextFormField(
                           style: TextStyle(color: const Color(0xFF272343)),
                           validator: (value) {
                             if (value.isEmpty) {
                               return 'Please enter some text';
                             }
                             return null;
                           },
                           decoration: new InputDecoration(
                               labelText: 'Confirm your password',
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
                 child: const Text('Submit', style: TextStyle(fontSize: 15)),
                ),
              )


              ),

              ),

                         Padding(
                           padding: const EdgeInsets.only(left:48,top:20.0),

                        child: Row(

                             children: <Widget>[

                             Text(
                                "if you already have an account"
                              ),
                             GestureDetector(
                           onTap: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => Login()),
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
                         ]
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
    );

  }
}
