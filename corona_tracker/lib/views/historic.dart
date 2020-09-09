import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



/// This is the stateless widget that the main application instantiates.
class historic extends StatefulWidget {
  historic({Key key}) : super(key: key);

  @override
  _historicState createState() => _historicState();
}

class _historicState extends State<historic> {
  //initialise classe FlutterSecureStorage to get email
  final storage = new FlutterSecureStorage();
  Future _future;
  Future getHistoric() async{
    final dynamic email = await storage.read(key: 'email');
   return await Firestore.instance.collection("historiques").where("email" ,isEqualTo: email).orderBy("timestamp").getDocuments();
  }
  //initState the Future function
  @override
  void initState() {
    _future=getHistoric();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('Historic of responses')),
        body: FutureBuilder(
        future: getHistoric(),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                  child: Text("Loading..."));
            default :
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return

                    Card(
                      child:Padding(
                          padding: EdgeInsets.only(left: 10.0),


                   child: Column(
                      children:<Widget>[

                        Text( DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index].data['timestamp']).toString()),
                            Row(
                            children:<Widget>[
                             Text("Age :",style:TextStyle(fontWeight: FontWeight.bold)),
                            Text(snapshot.data.documents[index].data['Age']),
                              ]
                            ),
                  Row(
                  children:<Widget>[
                  Text("Height :",style:TextStyle(fontWeight: FontWeight.bold)),
                    Text(snapshot.data.documents[index].data['Height']),
                  ]
                  ),   Row(
                  children:<Widget>[
                  Text("Weight :",style:TextStyle(fontWeight: FontWeight.bold)),
                            Text(snapshot.data.documents[index].data['Weight']),
                  ]
                  ),
                  Row(
                  children:<Widget>[
                  Text("new or worsening cough :",style:TextStyle(fontWeight: FontWeight.bold)),
                            Text(snapshot.data.documents[index].data['R1']),
                  ]
                  ),
                        Row(
                            children:<Widget>[
                              Text("difficulty breathing :",style:TextStyle(fontWeight: FontWeight.bold)),
                        Text(snapshot.data.documents[index].data['R2']),
                      ]
                    ),
                        Row(
                            children:<Widget>[
                              Text("new loss of smell or taste :",style:TextStyle(fontWeight: FontWeight.bold)),
                      Text(snapshot.data.documents[index].data['R3']),
                      ]
                  ),
                        Row(
                            children:<Widget>[
                              Text("fatigue or weakness :",style:TextStyle(fontWeight: FontWeight.bold)),
                  Text(snapshot.data.documents[index].data['R4']),
                  ]
                  ),
                        Row(
                            children:<Widget>[
                              Text("temperature >= 38°C :",style:TextStyle(fontWeight: FontWeight.bold)),
                  Text(snapshot.data.documents[index].data['R5']),
                  ]
                  ),
                  ]
                  )));
                      }
              );
              }
          }
        })));
  }}
