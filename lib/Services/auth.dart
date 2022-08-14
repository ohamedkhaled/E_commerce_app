import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class Auth {


  FirebaseAuth  auth=FirebaseAuth.instance;

  Future<UserCredential> Signup(String Email,String Password) async
  {
   // await Firebase.initializeApp();
    final authResult = await auth.createUserWithEmailAndPassword(email: Email, password: Password);
    return authResult ;

  }

  Future<UserCredential> Signin(String Email,String Password) async
  {
   // await Firebase.initializeApp();
    final authResult = await auth.signInWithEmailAndPassword(email: Email, password: Password);
    return authResult ;

  }

Future<void> logout() async{
    await   auth.signOut();
}
}