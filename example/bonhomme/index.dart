library bonhomme;

import 'dart:html';
import 'package:boarding/pieces.dart';
import 'package:boarding/boarding.dart';
import 'package:boarding/util.dart';

part 'model/trees.dart';
part 'model/bonhomme.dart';
part 'view/board.dart';

main() {
  new Board(querySelector('#canvas'), new Trees(64));
}