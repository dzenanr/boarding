library icacoe;

import 'dart:html';
import 'package:boarding/grids.dart';
import 'package:boarding/boarding.dart';

part 'model/square_grid.dart';
part 'view/board.dart';

main() {
  // model
  var grid = new SquareGrid(3);
  // view
  new Board(querySelector('#canvas'), grid).draw();
}


