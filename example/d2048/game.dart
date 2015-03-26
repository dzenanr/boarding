library d2048;

import 'dart:html';
import 'dart:math';
import 'package:boarding/grid.dart';
import 'package:boarding/boarding.dart';
import 'package:boarding/util.dart';

part 'model/grid.dart';
part 'view/board.dart';

main() {
  var canvas = querySelector('#canvas');
  var table = new Table(new Area(canvas.width, canvas.height), new Size(4, 4));
  new Board(canvas, new TileGrid(table)).draw();
}


