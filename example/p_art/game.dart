library p_art;

import 'dart:html';
import 'package:boarding/grid.dart';
import 'package:boarding/util.dart';
import 'package:boarding/boarding.dart';

part 'model/grid.dart';
part 'view/board.dart';

main() {
  var canvas = querySelector('#canvas');
  var table = new Table(new Area(canvas.width, canvas.height), new Size(200, 200));
  new Board(canvas, new ArtGrid(table)).draw();
}