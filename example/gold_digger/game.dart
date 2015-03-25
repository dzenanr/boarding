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
  new Board(querySelector('#canvas'), new BGrid(20, 20)).draw();
}