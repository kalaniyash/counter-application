import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:counter_app/screen/singup_screen.dart';
import 'package:counter_app/screen/splach_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splach_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final usercontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


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

bool isvisible = true;
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
                Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.blue),),
               SizedBox(height: 30,),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  maxRadius: 50,
                    child: Icon(Icons.person,size: 110,color: Colors.blue,)),
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
                SizedBox(height: 35,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40)
                  ),
                  // Inside onPressed of Login button
                  onPressed: () async {

                    if (_formkey.currentState!.validate()) {
                      var sharedPrefs = await SharedPreferences.getInstance();
                      sharedPrefs.setBool(SplachScreenState.KEYLOGIN, true);
                      String? storedEmail = sharedPrefs.getString('email');
                      String? storedPassword = sharedPrefs.getString('password');

                      // Check if entered details match with stored details
                      if (emailcontroller.text == storedEmail && passwordcontroller.text == storedPassword) {
                        // Navigate to HomeScreen if user exists
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } else {
                        // Show error message if user does not exist
                        Fluttertoast.showToast(
                          msg: "Plz first Signup.....",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3, // Set to 1 second instead of 0
                          backgroundColor: Colors.blue,
                          textColor: Colors.black,
                          fontSize: 15,
                        );
                      }
                    }
                  },
                  child: Text("Login",style: TextStyle(fontSize: 17),),
                  
                ),



                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account",style: TextStyle(fontSize: 17),),
                    TextButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>SingupScreen()));
                    },
                        child: Text("SignUp",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),))
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
