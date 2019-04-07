import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1_iremember/resources/firebase_auth_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailc = TextEditingController();
  final TextEditingController _passwordc = TextEditingController();

  Widget _buildPageContent(BuildContext context) {
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
                child: Text("LOGIN", style: TextStyle(color: Colors.pink, fontSize: 30.0, fontWeight: FontWeight.w700),),
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
                  controller: _passwordc,
                  obscureText: true,
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
              SizedBox(height: 20,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: _login,
                      color: Colors.cyan,
                      child: Text('Login', style: TextStyle(color: Colors.white70, fontSize: 16.0),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text('Forgot your password?', style: TextStyle(color: Colors.grey.shade500),),
              SizedBox(height: 40,),
              FlatButton(
                child: Text("Not registered? Signup", style: TextStyle(color: Colors.white),),
                onPressed: () => Navigator.pushNamed(context, 'signup'),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _login() async {
    print(_emailc.text);
    print(_passwordc.text);
    try {
      FirebaseUser user = await FirebaseAuthProvider().login(_emailc.text, _passwordc.text);
      print(user);
      // if(user!=null)
        // Navigator.pushNamed(context, 'home');
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(context),
    );
  }
}