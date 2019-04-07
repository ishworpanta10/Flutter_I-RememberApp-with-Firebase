import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1_iremember/resources/firebase_auth_provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailc = TextEditingController();

  final TextEditingController _passwordc = TextEditingController();

  final TextEditingController _confirmPasswordc = TextEditingController();

  Widget _buildPageContent() {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.grey.shade800,
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 50,),
              Container(
                height: 100, 
                child: Text("Signup".toUpperCase(), style: TextStyle(color: Colors.pink, fontSize: 30.0, fontWeight: FontWeight.w700),),
              ),
              SizedBox(height: 50,),
              ListTile(
                title: TextField(
                  controller: _emailc,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Email address:",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    icon: Icon(Icons.email, color: Colors.white30,)
                  ),
                )
              ),
              Divider(color: Colors.grey.shade600,),
              ListTile(
                title: TextField(
                  obscureText: true,
                  controller: _passwordc,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Password:",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    icon: Icon(Icons.lock, color: Colors.white30,)
                  ),
                )
              ),
              Divider(color: Colors.grey.shade600,),
              ListTile(
                title: TextField(
                  controller: _confirmPasswordc,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Confirm Password:",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    icon: Icon(Icons.lock, color: Colors.white30,)
                  ),
                )
              ),
              Divider(color: Colors.grey.shade600,),
              SizedBox(height: 20,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: _signup,
                      color: Colors.cyan,
                      child: Text('Signup', style: TextStyle(color: Colors.white70, fontSize: 16.0),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _signup() async  {
    print(_emailc.text);
    print(_passwordc.text);
    print(_confirmPasswordc.text);
    try {
      FirebaseUser user = await FirebaseAuthProvider().signup(_emailc.text, _passwordc.text);
      if(user == null)
        print("Signup failed");
    }catch(e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(),
    );
  }
}