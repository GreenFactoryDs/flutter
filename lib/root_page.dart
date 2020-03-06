import 'package:lostfound/login_page.dart';
import 'package:lostfound/tab_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'BottomNavigationBarProvider.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          return ChangeNotifierProvider<BottomNavigationBarProvider>.value(
         value: BottomNavigationBarProvider(),
          child: TabPage(snapshot.data));
        }else{
          return LoginPage();
        }
      },
    );
  }
}
