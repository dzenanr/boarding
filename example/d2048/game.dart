library d2048;

import 'dart:html';
import 'dart:math';
import 'package:boarding/grids.dart';
import 'package:boarding/boarding.dart';

part 'model/grid.dart';
part 'view/board.dart';

main() {
  new Board(querySelector('#canvas'), new GameGrid(4)).draw();
}


