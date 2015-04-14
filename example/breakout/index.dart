library breakout;

import 'dart:html';
import 'dart:math';
import 'package:boarding/pieces.dart';
import 'package:boarding/boarding.dart';
import 'package:boarding/util.dart';

part 'model/gear.dart';
part 'model/wall.dart';
part 'view/board.dart';
part 'view/bricks.dart';

main() {
  new Board(querySelector('#canvas'));
}
