library move;

import 'dart:html';
import 'package:boarding/pieces.dart';
import 'package:boarding/boarding.dart';

main() {
  var surface = new Surface();
  surface.canvas = querySelector('#canvas');
  surface.movablePieces = new MovablePieces();
  surface.movablePieces.create(8);
  surface.movablePieces.randomInit();
  surface.draw();
}