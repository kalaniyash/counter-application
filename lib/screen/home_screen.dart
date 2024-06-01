import 'dart:io';


import 'package:counter_app/screen/splach_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;
  int _counter = 0;
  var _userName = "";
  var _userEmail = "";
  var _userPassword = "";




  @override
  void initState() {
    super.initState();
    _loadCounter();
    _loadUserData(); // Load user data when the screen initializes

  }

  Future<void> _loadCounter() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = _prefs.getInt('counter') ?? 0;

    });
  }

  Future<void> _loadUserData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = _prefs.getInt('counter') ?? 0;
      _userName = _prefs.getString('name') ?? ''; // Retrieve user name
      _userEmail = _prefs.getString('email') ?? ''; // Retrieve user email
      _userPassword = _prefs.getString('password') ?? ''; // Retrieve user password
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _prefs.setInt('counter', _counter);
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
        _prefs.setInt('counter', _counter);
      });
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _prefs.setInt('counter', _counter);
    });
  }
  void _logout() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.remove('counter');
    sharedPrefs.remove(SplachScreenState.KEYLOGIN); // Remove login state
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplachScreen()),
    );
  }
 void alertdialog(){
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return AlertDialog(
         title: Center(child: Text("|| User Details ||",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 22),)),
       content: Column(
           mainAxisSize: MainAxisSize.min,
           crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Row(
            children: [
              Text(
                'Name: ',
                style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
              ),
              Text(
                '$_userName',
                style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ],
          ),
           SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Email: ',
                style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
              ),
              Text(
                '$_userEmail',
                style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ],
          ),
           SizedBox(height: 20),
          Row(children: [
            Text(
              'Password: ',
              style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
            ),
            Text(
              '$_userPassword',
              style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),
            ),
          ],)
         ],
         ),
         actions: [
           ElevatedButton(
             onPressed: () {
               Navigator.pop(context);
             },
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.black
             ),
             child: Text('Ok',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
           ),


         ],
       );
     },
   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () {
              // Close the application when back button is pressed
              exit(0);
            },
          ),
          centerTitle: true,
          title: Text("|| स्वामीनारायण मंत्र जाप ||",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Colors.black,),
              onSelected: (value){
                print(value);
                if (value == "user_details") {
                  // Handle user details action
                } else if (value == "logout") {
                  _logout(); // Call your logout function
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: "user_details",
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        alertdialog();

                      },
                      child: Text(
                        "User Details",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: "logout",
                    child: TextButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                          msg: "user logout.....",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3, // Set to 1 second instead of 0
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 15,

                        );
                        Navigator.pop(context); // Dismiss the popup menu
                        _logout(); // Call your logout function
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ),
                ];
              },
            ),
          ],


        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                //SizedBox(height: 20,),
                Image.asset('assets/images/swaminarayan_image.png',width: 250,),
                SizedBox(height: 40,),
                Text("$_counter",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,),),
                SizedBox(height: 50,),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                      backgroundColor: Colors.black
                  ),
                  child: Text("Count +",style: TextStyle(fontSize: 19),),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: _decrementCounter,
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                      backgroundColor: Colors.black
                  ),
                  child: Text("Count -",style: TextStyle(fontSize: 19),),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: _resetCounter,
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                      backgroundColor: Colors.black,
                  ),
                  child: Text("Clear",style: TextStyle(fontSize: 19),),
                ),
                SizedBox(height: 30,),
                //Text('Name: $_userName'),
                // Text('Email: $_userEmail'),
                // Text('Password: $_userPassword'),
                // TextButton(onPressed: _logout,
                //     child: Text("LOGOUT",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)
                //       ,),),
              ],
            ),
          ),
        )
    );
  }
}

