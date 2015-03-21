library move;

import 'dart:html';
import 'package:boarding/pieces.dart';
import 'package:boarding/boarding.dart';

main() {
  new Surface(querySelector('#canvas'), movablePieces: new MovablePieces(8)).draw();
}