library lanes;

import 'dart:html';
import 'package:boarding/pieces.dart';
import 'package:boarding/boarding.dart';

part 'model/lines.dart';
part 'view/board.dart';

void main() {
  new Board(querySelector('#canvas'));
}