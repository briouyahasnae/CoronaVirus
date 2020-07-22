import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged=>_firebaseAuth.onAuthStateChanged.map(
         (FirebaseUser user)=> user?.uid);
  //Signup
Future<String> createUserWithEP(String email,String password,String name ,String nom,String prenom,DateTime date) async{
final currentUser=await _firebaseAuth.createUserWithEmailAndPassword(
    email: email,
    password: password);
//update
var uuser=UserUpdateInfo();
uuser.displayName=name;
await currentUser.updateProfile(uuser);
await currentUser.reload();
return currentUser.uid;
}

//Signin

Future<String> SignInEP(String email,String password)  async {
  return(await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).uid;
}

//signOut()
Singout(){
  return _firebaseAuth.signOut();
}
}