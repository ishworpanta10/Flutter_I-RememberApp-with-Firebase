import 'package:flutter/material.dart';
import 'package:project1_iremember/ui/pages/login.dart';
import 'package:project1_iremember/ui/pages/signup.dart';
import './ui/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(App4());

class App4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IRemember',
      theme: ThemeData(primaryColor: Colors.deepOrange),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if(!snapshot.hasData) return LoginPage();

          if(snapshot.hasData){
            if(snapshot.data != null) {
              return HomePage();
            }else{
              return LoginPage();
            }
          }
        }
      ), 
      routes: {
        "signup": (_) => SignupPage(),
        "home": (_) => HomePage(),
      },
    );
  }
}
