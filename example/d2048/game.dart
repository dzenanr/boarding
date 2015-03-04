library d2048;

import 'dart:html';
import 'dart:math';
import 'package:boarding/grids.dart';
import 'package:boarding/boarding.dart';

part 'model/grid.dart';
part 'view/board.dart';

main() {
  /*
  var tileGrid;
  String tiles = window.localStorage[Board.jsonName];
  if (tiles != null) {
    tileGrid = new TileGrid.fromJsonString(4, tiles);
  } else {
    tileGrid = new TileGrid(4);
  }
   */
  new Board(querySelector('#canvas'), new TileGrid(4)).draw();
}


