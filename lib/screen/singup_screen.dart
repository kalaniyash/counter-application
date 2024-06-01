import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:counter_app/screen/login_screen.dart';
import 'package:counter_app/screen/splach_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_screen.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SingupScreen> {

  final usercontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final cpasscontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one digit';
    } else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value != passwordcontroller.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  bool isvisible = true;
  bool confrom = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            // Close the application when back button is pressed
            exit(0);
          },
        ),
        centerTitle: true,
        title: Text("Counter Application",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(

              children: [
                Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.blue),),
                SizedBox(height: 30,),
                CircleAvatar(
                    backgroundColor: Colors.transparent,
                    maxRadius: 50,
                    child: Icon(Icons.person,size: 110,color: Colors.blue,)),
                SizedBox(height: 20,),
                TextFormField(
                  validator: validateName,
                  controller: usercontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Name",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel), onPressed: () {
                      usercontroller.text = '';
                    },),
                    prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.person)),

                  ),

                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: validateEmail,
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel), onPressed: () {
                      emailcontroller.text = '';
                    },),
                    prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.email)),

                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: validatePassword,
                  maxLength: 9,
                  obscureText: isvisible,
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        isvisible=!isvisible;
                      });
                    },icon: Icon(
                        isvisible ? Icons.visibility_off : Icons.visibility),),
                    prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.lock)),

                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: validateConfirmPassword,
                  maxLength: 9,
                  obscureText: confrom,
                  controller: cpasscontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Confrom Password",
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        confrom=!confrom;
                      });
                    },icon: Icon(
                        confrom ? Icons.visibility_off : Icons.visibility),),
                    prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.lock)),

                  ),
                ),
                SizedBox(height: 35,),
                ElevatedButton(

                  // Inside onPressed of Sign Up button
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      // Save user details in SharedPreferences
                      var sharedPrefs = await SharedPreferences.getInstance();
                      sharedPrefs.setString('name', usercontroller.text);
                      sharedPrefs.setString('email', emailcontroller.text);
                      sharedPrefs.setString('password', passwordcontroller.text);

                      // Navigate to LoginScreen after successful signup
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  },
                  child: Text("Sign Up",style: TextStyle(fontSize: 17),),


                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an Account",style: TextStyle(fontSize: 17),),
                    TextButton(onPressed: (){
                      Navigator.pop(context,MaterialPageRoute(builder: (context) =>LoginScreen()));
                    },
                        child: Text("Login",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
