library chaos;

import 'dart:html';
import 'package:boarding/boarding_model.dart';
import 'package:boarding/boarding.dart';

part 'view/board.dart';

main() {
  new Board(querySelector('#canvas')).draw();
}