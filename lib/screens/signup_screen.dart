import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../reusable_widgets/resuable_widget.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController=TextEditingController();
  TextEditingController _usernameTextController=TextEditingController();
  TextEditingController _emailTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.purple,Colors.blue.shade900],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 200,),
              reuableTextField("Enter UserName", Icons.person, false, _usernameTextController),
              SizedBox(height: 30,),

              reuableTextField("Enter Email Id", Icons.person, false, _emailTextController),
              SizedBox(height: 30,),

              reuableTextField("Enter Password", Icons.lock, true, _passwordTextController),
              SizedBox(height: 20,),
              signInSignUpButton(context, false, () {
                FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text).then((value) {
                  print("Created New Account");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });

              }),
              SizedBox(height: 10,),



            ],
          ),
        ),) ,
    );;
  }
}
