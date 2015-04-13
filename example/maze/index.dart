library maze;

import 'dart:html';
import 'package:boarding/grid.dart';
import 'package:boarding/util.dart';
import 'package:boarding/boarding.dart';

part 'view/board.dart';

main() {
  var canvas = querySelector('#canvas');
  var table = new Table.from(new Size.from(30, 30),
                             new Area.from(canvas.width, canvas.height));
  new Board(canvas, new MazeGrid(table)).draw();
}