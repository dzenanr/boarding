library blast;

import 'dart:html';
import 'package:boarding/grid.dart';
import 'package:boarding/boarding.dart';
import 'package:boarding/util.dart';

part 'model/grid.dart';
part 'view/board.dart';

void main() {
  new Board(querySelector('#canvas'));
}


