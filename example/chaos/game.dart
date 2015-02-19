library chaos;

import 'dart:html';
import 'package:boarding/boarding_model.dart';
import 'package:boarding/boarding.dart';

part 'model/grid2by2.dart';
part 'view/board.dart';

main() {
  new Board(new Grid2By2(), querySelector('#canvas')).draw();
}