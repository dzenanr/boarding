library memory;

import 'dart:async';
import 'dart:html';
import 'package:boarding/grid.dart';
import 'package:boarding/boarding.dart';
import 'package:boarding/util.dart';

part 'model/memory.dart';
part 'view/board.dart';

playAgain(Event e) {
  window.location.reload();
}

main() {
  var canvas = querySelector('#canvas');
  var table = new Table(new Area(canvas.width, canvas.height), new Size(4, 4));
  new Board(querySelector('#canvas'), new Memory(table)).draw();
  querySelector('#play').onClick.listen(playAgain);
}


