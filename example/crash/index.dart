library crash;

import 'dart:html';
import 'package:boarding/pieces.dart';
import 'package:boarding/boarding.dart';
import 'package:boarding/util.dart';

part 'model/cars.dart';
part 'view/board.dart';

void main() {
  new Board(querySelector('#canvas'));
}