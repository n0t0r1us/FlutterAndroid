// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:laptrinhdidong/Firebase/page_firebase_app.dart';
//
// class Login_page extends StatefulWidget {
//   const Login_page({Key? key}) : super(key: key);
//
//   @override
//   State<Login_page> createState() => _Login_pageState();
// }
//
// class _Login_pageState extends State<Login_page> {
//   TextEditingController txtEmail = TextEditingController();
//   TextEditingController txtPass = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//           TextField(
//             controller: txtEmail,
//             decoration: InputDecoration(
//             label: Text("Email:"),
//             )
//           ),
//           TextField(
//             controller: txtPass,
//             decoration: InputDecoration(
//             label: Text("Password:"),
//             )
//           ),
//             ElevatedButton(
//                 onPressed: () async{
//                   var dn = null;
//                   dn = await signWithEmailPassword(email: txtEmail.text, password: txtPass.text);
//                   if(dn != null)
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFirebaseApp()));
//                 },
//                 child: Text("Sign in with Email"),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Do not have an account"),
//                 FlatButton(
//                   child: Text("nhan vao day"),
//                   onPressed: (){
//
//                   },
//                 )
//               ],
//             ),
//             ElevatedButton(
//                 onPressed: () {
//
//                 },
//                 child: Text("Sign in with Google"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// Future<UserCredential> signWithEmailPassword({required String email , required String password} ) async{
//   try{
//     var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
//     return userCredential;
//   }
//   on FirebaseAuthException catch(e){
//     return Future.error(e.code);
//   }
// }
//



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:laptrinhdidong/Firebase/page_firebase_app.dart';

import 'LoginWith.dart';
import 'Register_page.dart';
import 'diaglog.dart';



class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    TextEditingController txtEmail = TextEditingController();
    TextEditingController txtPass = TextEditingController();
    return Scaffold(
      appBar: AppBar(

          title: Text("Login")
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: txtEmail,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextFormField(
                  controller: txtPass,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await signWithEmailPassword(email: txtEmail.text,password: txtPass.text).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFirebaseApp())));
                    }, child: Text("Dang nhap voi Email")
                ),
                SizedBox(height: 20,),
                Row(
                  children: [

                    Text("Dont have an account"),
                    const SizedBox(width: 10,),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
                    }, child: Text("register"))
                  ],),
                ElevatedButton(
                    onPressed: () async {
                      await signWithGoogle().whenComplete(() =>
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const MyFirebaseApp())))
                      ;
                      //page firebase
                    }, child: Text("Dang nhap voi google")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
