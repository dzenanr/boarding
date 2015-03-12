library attract;

import 'dart:html';
import 'package:boarding/pieces.dart';
import 'package:boarding/boarding.dart';

part 'view/board.dart';

main() {
  new Board(querySelector('#canvas')).draw();
}