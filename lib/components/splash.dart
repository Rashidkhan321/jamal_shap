
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../view_moduls/authentications/login/login_screen.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> with TickerProviderStateMixin{
  late final controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this)..repeat();

  @override
  void initState() {

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder:
          (controller)=>loginscreen()));

    });

    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
   // controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor:  Colors.white70,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height*0.3,
          width: MediaQuery.of(context).size.width*0.29,


          child:    CircleAvatar(
          radius: 200,
    backgroundImage:AssetImage('images/img.png',

    ),


        ),
      ),

    ));
  }
}
