import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takalam_gp/Cubit/states.dart';
import 'package:takalam_gp/Networking/fixingModel.dart';
import 'package:takalam_gp/Networking/predictionModel.dart';
import 'package:takalam_gp/Model/signModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:path/path.dart';

class takalamCubit extends Cubit<takalamStates> {
  takalamCubit() : super(takalamInitialState());

  static takalamCubit get(context) => BlocProvider.of(context);

  List<Widget> writtenSigns = [];
  List<String> textSigns = [];

  String mask = "[MASK]";
  String toBeprdeicted = "";
  String fixedSentence = "";
  String combinedWord = "";
  List<String> predictedSigns = [];
  Database database;
  List<Sign> SignsList = [];
  List<Map> signs;
  List<Sign> letters = [];
  List<Sign> pronouns = [];
  List<Sign> shopping = [];
  List<Sign> food = [];
  List<Sign> common = [];
  List<Sign> gov = [];
  List<Sign> numbers = [];
  List<Sign> question = [];
  List<Sign> hospital = [];

  List<int> fixIDs = [];

  var dbPath;

  void predb() async {
    var dbDir = await getDatabasesPath();
    dbPath = join(dbDir, "Test.db");

    print(dbPath);
    ByteData data = await rootBundle.load("assets/Test.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
  }

  void openDB() async {
    var dbDir = await getDatabasesPath();
    dbPath = join(dbDir, "Test.db");
    database = await openDatabase(dbPath, version: 1, onOpen: (database) {
      print("opened");
      getFromDB(database).then((value) {
        for (int i = 0; i < signs.length; i++) {
          Uint8List image = Uint8List.fromList(signs[i]['Sign']);
          Sign newSign = new Sign(signs[i]['Text'],
              id: signs[i]['id'], category: signs[i]['Category'], sign: image);
          SignsList.add(newSign);
        }
        print("Added to list " + SignsList.length.toString());
        fillLetters();
        emit(getFromDatabaseState());
      }).catchError((error) {
        print("ERRRROOORRRR ");
        print(error);
      });

      emit(databaseOpenedState());
    });
  }

  Future<void> getFromDB(database) async {
    signs = await database.rawQuery("Select * FROM AllSigns");
    print("retrieved " + signs.length.toString());
  }

  void chooseSign(Widget sign, Sign signObj) {
    emit(takalamSelectSignState());
    toBeprdeicted = "";
    writtenSigns.add(sign);

    if (signObj.category == "l") {
      combinedWord += signObj.text;
      textSigns.add(combinedWord);
      predictedSigns.clear();
      toBeprdeicted += combinedWord;
      toBeprdeicted += mask;
      predict(toBeprdeicted);
      print(combinedWord);
    } else {
      textSigns.add(signObj.text);
      if (writtenSigns.length != 0) {
        predictedSigns.clear();
        toBeprdeicted += signObj.text;
        toBeprdeicted += mask;
        predict(toBeprdeicted);
      }
    }
  }

  void clearWritten() {
    writtenSigns.clear();
    predictedSigns.clear();
    textSigns.clear();
    toBeprdeicted = "";
    emit(takalamClearAllSignState());
  }

  void deleteSign() {
    toBeprdeicted.replaceAll(textSigns[textSigns.length - 1], '');
    print((toBeprdeicted));
    predictedSigns.clear();
    writtenSigns.removeAt(writtenSigns.length - 1);
    textSigns.removeAt(textSigns.length - 1);
    if (writtenSigns.length != 0) predict(toBeprdeicted);
    emit(takalamRemoveSignState());
  }

  void predict(String query) {
    emit(takalamPredictionState());

    PredictionDio.postData(
        url: 'models/rowidabelaal/wordpred_arabert',
        body: {'inputs': query}).then((value) {
      for (int i = 0; i < 3; i++) {
        predictedSigns.add(value.data[i]['token_str']);
      }

      //print(json.decode(value.data['token']));
      emit(takalamPredictionState());
    }).catchError((error) {
      print(error.toString());
      emit(takalamErrorState());
    });
  }

  void fixGrammar(String toBeFixed) {
    FixingDio.getFixed(url: '', query: {'IDs_Sentence': toBeFixed})
        .then((value) {
      //print(value.data["Sentence"]);
      fixedSentence = value.data["Sentence"];
      print(fixedSentence);
      emit(takalamFixGrammarState());
    }).catchError((error) {
      print(error.toString());
      emit(takalamErrorState());
    });
  }

  Sign isFound(String txt) {
    for (int i = 0; i < SignsList.length; i++) {
      if (SignsList[i].text == txt) {
        return SignsList[i];
      }
    }
  }

  void fillLetters() {
    //print(SignsList);
    for (int i = 0; i < SignsList.length; i++) {
      if (SignsList[i].category == "l") {
        letters.add(SignsList[i]);
      }
      else if (SignsList[i].category == "n") {
        numbers.add(SignsList[i]);
      }
      else if (SignsList[i].category == "p") {
        pronouns.add(SignsList[i]);
      }
      else if (SignsList[i].category == "h") {
        hospital.add(SignsList[i]);
      }
      else if (SignsList[i].category == "g") {
        gov.add(SignsList[i]);
      }
      else if (SignsList[i].category == "c") {
        common.add(SignsList[i]);
      }
      else if (SignsList[i].category == "f") {
        food.add(SignsList[i]);
      }
      else if (SignsList[i].category == "s") {
        shopping.add(SignsList[i]);
      }
      else if (SignsList[i].category == "f") {
        food.add(SignsList[i]);
      }

    }
    print(letters.length);
  }

  String beforeFixing() {
    for (int i = 0; i < textSigns.length; i++) {
      for (int j = 0; j < SignsList.length; j++) {
        if (textSigns[i] == SignsList[j].text) {
         fixIDs.add(SignsList[j].id);
        }
      }
    }
    String tmpFix = fixIDs.join(',');
    return tmpFix;

  }
}
