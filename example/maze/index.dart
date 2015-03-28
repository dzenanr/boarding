library maze;

import 'dart:html';
import 'package:boarding/grid.dart';
import 'package:boarding/util.dart';
import 'package:boarding/boarding.dart';

part 'view/board.dart';

main() {
  var canvas = querySelector('#canvas');
  var table = new Table(new Area(canvas.width, canvas.height), new Size(30, 30));
  new Board(canvas, new MazeGrid(table)).draw();
}