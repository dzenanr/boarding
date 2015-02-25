library pingpong;

import 'dart:html';
import 'dart:math';
import 'package:boarding/boarding.dart';

part 'view/ball.dart';
part 'view/board.dart';
part 'view/racket.dart';

main() {
  new Board(querySelector('#canvas'));
}
