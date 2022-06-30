import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takalam_gp/Cubit/cubit.dart';
import 'package:takalam_gp/Cubit/states.dart';
import 'package:takalam_gp/Screens/MainScreen.dart';
import 'package:flutter_tts/flutter_tts.dart';


class ResultsScreen extends StatelessWidget {

  final FlutterTts tts = FlutterTts();
  home() {
    tts.setLanguage('ar');
    tts.setSpeechRate(0.5);
    tts.setVolume(1.0);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<takalamCubit, takalamStates>(
        listener:(context , state){} ,
        builder: (context , state){
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      child: Text(
                        takalamCubit.get(context).fixedSentence,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Tajawal"
                        ),
                      ),
                      height: 300,
                      width: 450,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.cyan[800]),
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),

                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(onPressed: (){
                      tts.speak(takalamCubit.get(context).fixedSentence);
                    },
                      color: Colors.cyan[800],
                      height: 70,
                      minWidth: 70,
                      child: Icon(Icons.record_voice_over , size: 40, color: Colors.white,),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.cyan[800],)
                      ),
                    ),
                    SizedBox(width: 10,),
                    MaterialButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => mainScreen()),
                      );

                    },
                      color: Colors.cyan[800],
                      height: 70,
                      minWidth: 70,
                      child: Icon(Icons.done_outline,  size: 40, color: Colors.white,),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.cyan[800],)
                      ),
                    )
                  ],

                ),

              ],

            ),
          );
        }

      );
  }

  ResultsScreen(context);
}
