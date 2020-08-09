import 'package:flutter/material.dart';

class Shownotification extends StatelessWidget {
  var height;
  var width;
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
          appBar: AppBar(
            title: Text("Notifications"),
          ),
        body: SingleChildScrollView(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,//Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[

               Center(
                        child: Icon(Icons.warning,color: Colors.red,size: 100)

                ),
                Center(
                      child: Text("Pay attention",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)

                ),
                SizedBox(
                  height:height/20,
                ),
                Center(
               child: Text("For your benefit, follow these instructions:",style: TextStyle(fontSize: 16,color: Colors.red,decoration: TextDecoration.underline))),
                SizedBox(
                  height:height/30,
                ),
                Text("1-call ahead to your local emergency facility: Notify the operator about your symptoms",style: TextStyle(fontWeight:FontWeight.bold )),
                SizedBox(
                  height:height/40,
                ),
                Text("2-Stay at home"),
                SizedBox(
                  height:height/40,
                ),
                Text("3-Stay at an isolate room"),
                SizedBox(
                  height:height/40,
                ),
                Text("4-Wear your mask"),
                SizedBox(
                  height:height/40,
                ),
                Text("5-Cover your coughs and sneezes with a tissue and throw the tissue in the trash"),
               SizedBox(
                  height:height/40,
                ),
                Text("6-Wash your hands often with soap and water for at least 20 seconds"),
                SizedBox(
                  height:height/40,
                ),
                Text("7-If soap and water are not readily available, use an alcohol-based hand sanitizer with at least 60% alcohol"),

//
//.

              ],


              )
        )
      );
  }
}
