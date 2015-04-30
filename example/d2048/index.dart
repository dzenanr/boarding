library d2048;

import 'dart:html';
import 'dart:math';
import 'package:boarding/grid.dart';
import 'package:boarding/boarding.dart';
import 'package:boarding/util.dart';

part 'model/grid.dart';
part 'view/board.dart';

void main() {
  var canvas = querySelector('#canvas');
  var table = new Table.from(new Size.from(4, 4),
                             new Area.from(canvas.width, canvas.height));
  new Board(canvas, new TileGrid(table));
}


