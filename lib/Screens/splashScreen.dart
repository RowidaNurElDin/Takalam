import 'dart:async';

import 'package:flutter/material.dart';
import 'package:takalam_gp/Screens/MainScreen.dart';
import 'package:flutter_fadein/flutter_fadein.dart';


class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 10), () =>
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => mainScreen())));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: FadeIn(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Center(
                child: Image(
                  image: AssetImage('assets/images/Kalam.png'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  "تكلم",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Tajawal",
                      color: Colors.cyan[800]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 90,
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/anta.png')),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 90,
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/nasma3.png')),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 90,
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/na7n.png')),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          )),
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  "نحن نسمعك",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Tajawal",
                      color: Colors.cyan[800]),
                ),
              ),
            ],
          ),
          duration: Duration(seconds: 3),
        ),
      ),
    );
  }
}
