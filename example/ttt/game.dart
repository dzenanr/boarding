library icacoe;

import 'dart:html';
import 'package:boarding/grid.dart';
import 'package:boarding/util.dart';
import 'package:boarding/boarding.dart';

part 'model/ttt_grid.dart';
part 'view/board.dart';

main() {
  var canvas = querySelector('#canvas');
  var table = new Table(new Area(canvas.width, canvas.height), new Size(3, 3));
  new Board(canvas, new TttGrid(table)).draw();
}


