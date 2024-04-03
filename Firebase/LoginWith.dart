
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
Future<UserCredential> registerEmailPassword({required String email,required String password}){
  try{
    return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }
  on FirebaseAuthException catch(e){
    return Future.error(e.code);
  }
}
Future<UserCredential> signWithEmailPassword({required String email , required String password} ) async{
  try{
    var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
  on FirebaseAuthException catch(e){
    return Future.error(e.code);
  }
}
Future<UserCredential> signWithGoogle() async{
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googelAuth = await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
      accessToken: googelAuth?.accessToken,
      idToken: googelAuth?.idToken
  );
  return FirebaseAuth.instance.signInWithCredential(credential);
}
