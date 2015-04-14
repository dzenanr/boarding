library move;

import 'dart:html';
import 'package:boarding/pieces.dart';
import 'package:boarding/boarding.dart';

main() {
  var surface = new Surface();
  surface.canvas = querySelector('#canvas');
  surface.pieces = new Pieces();
  surface.pieces.create(8);
  surface.pieces.randomInit();
}