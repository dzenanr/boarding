library d2048;

import 'dart:html';
import 'dart:math';
import 'package:boarding/grid.dart';
import 'package:boarding/boarding.dart';
import 'package:boarding/util.dart';

part 'model/grid.dart';
part 'view/board.dart';

main() {
  new Board(querySelector('#canvas'), new TileGrid(4)).draw();
}


