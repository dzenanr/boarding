library move;

import 'dart:html';
import 'package:boarding/pieces.dart';
import 'package:boarding/boarding.dart';

main() {
  var mps = new MovablePieces(8);
  mps.randomInit();
  new Surface(querySelector('#canvas'), movablePieces: mps).draw();
}