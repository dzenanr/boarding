library p_art;

import 'dart:html';
import 'package:boarding/grid.dart';
import 'package:boarding/util.dart';
import 'package:boarding/boarding.dart';

part 'model/grid.dart';
part 'view/board.dart';

main() {
  new Board(querySelector('#canvas'), new ArtGrid(200, 200)).draw();
}