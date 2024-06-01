import 'package:counter_app/screen/splach_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter Application',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue
      ),
      home: SplachScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Counter Application",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
