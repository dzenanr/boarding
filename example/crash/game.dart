library crash;

import 'dart:html';
import 'package:boarding/grid.dart';
import 'package:boarding/pieces.dart';
import 'package:boarding/boarding.dart';
import 'package:boarding/util.dart';

part 'model/cars.dart';
part 'view/board.dart';

main() {
  new Board(querySelector('#canvas')).draw();
}