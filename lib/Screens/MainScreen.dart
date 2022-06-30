import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takalam_gp/Cubit/cubit.dart';
import 'package:takalam_gp/Cubit/states.dart';
import 'package:takalam_gp/Model/signModel.dart';
import 'package:takalam_gp/Screens/ResultScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class mainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    takalamCubit.get(context).predb();
    takalamCubit.get(context).openDB();

    //takalamCubit.get(context).fillLetters();

    Sign tmp;
    return BlocConsumer<takalamCubit, takalamStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //takalamCubit.get(context).predb();
          //takalamCubit.get(context).getFromDB(db);
          return Scaffold(
            appBar: AppBar(

            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.cyan[500],
                              border: Border.all(
                                color: Colors.cyan[500],
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20))

                          ),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: new List.generate(
                              takalamCubit.get(context).writtenSigns.length,
                              (index) =>
                                  takalamCubit.get(context).writtenSigns[index],
                            ),
                          ))), //Signs written
                  SizedBox(
                    height: 8,
                  ),

                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.cyan[100],
                              border: Border.all(
                                color: Colors.cyan[100],
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20))

                          ),
                          child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: new List.generate(
                      takalamCubit.get(context).predictedSigns.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            onPressed: () {
                              String tmpTxt = takalamCubit
                                  .get(context)
                                  .predictedSigns[index];
                            },
                            child: new Container(
                                child: Center(
                                  child: tmp == null ? Text(
                                    "${takalamCubit.get(context).predictedSigns[index]}",
                                    style: TextStyle(fontSize: 20),
                                  ) : sign(context, tmp), //FOR NOW
                                ),
                                width: 90,
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20.0),
                                )),
                          ),
                        );
                      },
                    ),
                  ))),

                  // Predcited Signs Section
                  SizedBox(
                    height: 8,
                  ),
                  DefaultTabController(

                      length: 9, // length of tabs
                      initialIndex: 0,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: TabBar(
                                labelColor: Colors.green[300],
                                unselectedLabelColor: Colors.cyan[800],
                                tabs: [
                                  Tab(icon: Icon(FontAwesomeIcons.handPointUp, size :30),), //Letters
                                  Tab(icon:Icon(FontAwesomeIcons.calculator, size :30) ),
                                  Tab(icon:Icon(FontAwesomeIcons.person, size :30) ),
                                  Tab(icon:Icon(FontAwesomeIcons.question, size :30) ),
                                  Tab(icon:Icon(FontAwesomeIcons.cartShopping, size :30) ),
                                  Tab(icon:Icon(Icons.fastfood, size :30) ),
                                  Tab(icon:Icon(FontAwesomeIcons.hospital, size :30) ),
                                  Tab(icon:Icon(Icons.local_police_outlined, size :30) ),
                                  Tab(icon:Icon(Icons.all_inclusive, size :30) ),

                                ],
                                isScrollable: true,
                              ),
                            ),
                            Container(
                                height: 400, //height of TabBarView
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.grey, width: 0.5))),
                                child: TabBarView(children: <Widget>[
                                  grid(context , takalamCubit.get(context).letters.length ,takalamCubit.get(context).letters ),
                                  grid(context , takalamCubit.get(context).numbers.length ,takalamCubit.get(context).numbers ),
                                  grid(context , takalamCubit.get(context).pronouns.length ,takalamCubit.get(context).pronouns ),
                                  grid(context , takalamCubit.get(context).question.length ,takalamCubit.get(context).question ),
                                  grid(context , takalamCubit.get(context).shopping.length ,takalamCubit.get(context).shopping ),
                                  grid(context , takalamCubit.get(context).food.length ,takalamCubit.get(context).food ),
                                  grid(context , takalamCubit.get(context).hospital.length ,takalamCubit.get(context).hospital ),
                                  grid(context , takalamCubit.get(context).gov.length ,takalamCubit.get(context).gov ),
                                  grid(context , takalamCubit.get(context).common.length ,takalamCubit.get(context).common ),


                                ]))
                          ])), // Signs Tabs Categorized
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          takalamCubit.get(context).deleteSign();
                        },
                        color: Colors.red[300],
                        child: Icon(Icons.arrow_back , color: Colors.white),
                        height: 50,
                        minWidth: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red[300])),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      MaterialButton(
                        onPressed: () {
                          String toBeFixed =
                              takalamCubit.get(context).beforeFixing();
                          print("To be fixed " + toBeFixed);
                          takalamCubit.get(context).fixGrammar(toBeFixed);
                          takalamCubit.get(context).clearWritten();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultsScreen(context)),
                          );
                        },
                        color: Colors.cyan[800],
                        height: 50,
                        minWidth: 50,
                        child: Icon(Icons.thumb_up , color: Colors.white,),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.grey)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

Widget sign(context , Sign signObj ) => Padding(
  padding: const EdgeInsets.all(8.0),
  child:   MaterialButton(

        onPressed: () {

          takalamCubit.get(context).chooseSign(sign(context, signObj), signObj);

        },

        shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(18.0),

            side: BorderSide(color: Colors.cyan[500])),

        child: Container(

            width: 90,

            height: 120,

            decoration: BoxDecoration(

                image: DecorationImage(

                    fit: BoxFit.fill,

                    image: new Image.memory(signObj.sign).image

                ),
                borderRadius: BorderRadius.all(Radius.circular(20),
        )),

      ),
));
Widget grid(context , int count ,  List<Sign> signObj  ) =>GridView.builder(
    gridDelegate:
    const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
    ),
    scrollDirection: Axis.vertical,
    itemCount: count,

    itemBuilder:
        (BuildContext context, int index) {

      return sign(context, signObj[index]);

    });

