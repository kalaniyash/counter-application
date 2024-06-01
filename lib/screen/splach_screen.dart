import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => SplachScreenState();
}

class SplachScreenState extends State<SplachScreen> {
  static const String KEYLOGIN = "Login";
  static const String KEYSIGNUP = "Login";

  @override
  void initState() {
    super.initState();
    wharetogo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("|| सब मोह माया है ||",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),
              Image.asset('assets/images/yoga_logo.png', width: 250,),
            ],
          ),
        )
    );
  }

  void wharetogo() async {
    var sharedpre = await SharedPreferences.getInstance();
    var isLoginin = sharedpre.getBool(KEYLOGIN);
    var isSignedUp = sharedpre.getBool(
        KEYSIGNUP); // This should be a different key if used for signup

    Timer(Duration(seconds: 3), () {
      if (isLoginin != null) {
        if (isLoginin) {
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }


}