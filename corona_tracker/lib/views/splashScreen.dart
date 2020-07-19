import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  final backgroundColor=const Color(0xFFf4f4f6);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
       height:MediaQuery.of(context).size.height ,
       color:backgroundColor ,
        child :Padding(

        padding: const EdgeInsets.only(top: 140),


        child: SafeArea(
            child: Column(

                children:<Widget>[
                  Text(
                      "Welcome",
                      style:TextStyle(
                          color:const Color(0xFF272343),
                          fontSize:30,
                        fontWeight: FontWeight.bold,

                      )
                  ),

                  Image.asset('assets/images/logo.png',
                    width: 80,
                    height: 80,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left:50,top:10),
                      child:Row(

                      children:<Widget>[

                      Text(
                        "Let's act against ",
                        style:TextStyle(
                          color:const Color(0xFF272343),
                          fontSize:20,
                          fontWeight: FontWeight.bold,

                        )
                    ),
                        Text(
                            "Covid-19",
                            style:TextStyle(
                              color:Colors.green,
                              fontSize:20,
                              fontWeight: FontWeight.bold,

                            )
                        ),
                  ]
                    )
                  )
                ],
        )
        ),
      ),
    ),
    );
  }
}
