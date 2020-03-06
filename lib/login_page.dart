import 'package:firebase_auth/firebase_auth.dart';
import 'package:lostfound/tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Chuno DS',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                 _handelSignIn().then((user){
                   Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context)=> TabPage(user)));
                   print(user);
                 });
              },
            ),SignInButton(
              Buttons.Facebook,
              onPressed: () {
                 _handelSignIn().then((user){
                   Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context)=> TabPage(user)));
                   print(user);
                 });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> _handelSignIn() async {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      FirebaseUser user = (await _firebaseAuth.signInWithCredential(
        GoogleAuthProvider.getCredential(idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken))).user;
      print("signed In :" +user.displayName);
      return user;
  }

}
