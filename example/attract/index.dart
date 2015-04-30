library attract;

import 'dart:html';
import 'package:boarding/pieces.dart';
import 'package:boarding/util.dart';
import 'package:boarding/boarding.dart';

part 'view/board.dart';

void main() {
  new Board(querySelector('#canvas'));
}