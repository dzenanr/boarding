library icacoe;

import 'dart:html';
import 'package:boarding/grids.dart';
import 'package:boarding/boarding.dart';

part 'model/ttt_grid.dart';
part 'view/board.dart';

main() {
  // model
  var grid = new TttGrid(3);
  // view
  new Board(querySelector('#canvas'), grid).draw();
}


