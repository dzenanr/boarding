library gold_digger;

import 'dart:async';
import 'dart:html';
import 'package:boarding/grid.dart';
import 'package:boarding/pieces.dart';
import 'package:boarding/util.dart';
import 'package:boarding/boarding.dart';

part 'model/ball.dart';
part 'model/grid.dart';
part 'view/board.dart';

main() {
  var canvas = querySelector('#canvas');
  var table = new Table(new Area(canvas.width, canvas.height), new Size(20, 20));
  new Board(canvas, new DGrid(table)).draw();
}