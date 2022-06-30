import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Sign{
  Uint8List sign ;
  String text;
  String category;
  int id ;


  Sign(this.text , {this.id , this.category , this.sign} );
}