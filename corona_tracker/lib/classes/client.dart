import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
   var documentReference;
  String age;
  String email,height,weight;
 String r1,r2,r3,r4,r5;
  Client.data(this.documentReference,
  [
     this.age,
    this.height,
    this.weight,
        this.r1,
        this.r2,
        this.r3,
        this.r4,
        this.r5,
        this.email,
       ]) {
    this.age ??= '';
    this.height ??= '';
    this.weight??='';
    this.r1 ??= '';
    this.r2 ??= '';
    this.r3 ??= '';
    this.r4??= '';
    this.r5??= '';
    this.email ??= '';

  }

  factory Client.from(var document) => Client.data(
      document != null ? document.reference : null, document.data['Age'].toString() ,
    document.data['Height'].toString(),
    document.data['Weight'].toString(),
    document.data['R1'].toString(),
    document.data['R2'].toString(),
    document.data['R3'].toString(),
    document.data['R4'].toString(),
    document.data['R5'].toString(),
    document.data['email'].toString()
  );

  Map<String, String> toMap() {
    return {
      'age': age,
      'height': height,
      'weight': weight,
      'email': email,
      'r1': r1,
      'r2': r2,
      'r3': r3,
      'r4': r4,
      'r5': r5,
    };
  }


}
