library p_art;

import 'dart:html';
import 'package:boarding/grid.dart';
import 'package:boarding/util.dart';
import 'package:boarding/boarding.dart';

part 'model/grid.dart';
part 'view/board.dart';

void main() {
  var canvas = querySelector('#canvas');
  var table = new Table.from(new Size.from(200, 200),
                             new Area.from(canvas.width, canvas.height));
  new Board(canvas, new ArtGrid(table));
}