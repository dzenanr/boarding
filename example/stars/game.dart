library stars;

import 'dart:html';
import 'package:boarding/pieces.dart';
import 'package:boarding/util.dart';
import 'package:boarding/boarding.dart';

part 'model/stars.dart';
part 'view/board.dart';

main() {
  new Board(querySelector('#canvas')).draw();
}