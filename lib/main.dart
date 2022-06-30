import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takalam_gp/Networking/fixingModel.dart';
import 'package:takalam_gp/Networking/predictionModel.dart';
import 'package:takalam_gp/Screens/MainScreen.dart';
import 'package:takalam_gp/Screens/ResultScreen.dart';

import 'Cubit/cubit.dart';
import 'Screens/splashScreen.dart';

void main() async{
  PredictionDio.init();
  FixingDio.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => takalamCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            scaffoldBackgroundColor: Colors.white,
            textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                )
            ),
            appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark)),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black)
        ),

        home: splashScreen() ,

      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

