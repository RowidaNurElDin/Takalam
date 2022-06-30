import 'package:bloc/bloc.dart';

abstract class takalamStates{}

class takalamInitialState extends takalamStates{}

class takalamPredictionState extends takalamStates{}

class takalamSelectSignState extends takalamStates{}

class takalamClearAllSignState extends takalamStates{}

class takalamRemoveSignState extends takalamStates{}

class takalamFixGrammarState extends takalamStates{}

class takalamErrorState extends takalamStates{}

class databaseOpenedState extends takalamStates{}

class getFromDatabaseState extends takalamStates{}