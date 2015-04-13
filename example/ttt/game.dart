library icacoe;

import 'dart:html';
import 'package:boarding/grid.dart';
import 'package:boarding/util.dart';
import 'package:boarding/boarding.dart';

part 'model/ttt_grid.dart';
part 'view/board.dart';

main() {
  var canvas = querySelector('#canvas');
  var table = new Table.from(new Size.from(3, 3),
                             new Area.from(canvas.width, canvas.height));
  new Board(canvas, new TttGrid(table)).draw();
}


