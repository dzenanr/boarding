library memory;

import 'dart:async';
import 'dart:html';
import 'package:boarding/boarding.dart';

part 'model/memory.dart';
part 'view/board.dart';

playAgain(Event e) {
  window.location.reload();
}

main() {
  var canvas = querySelector('#canvas');
  ButtonElement play = querySelector('#play');
  play.onClick.listen(playAgain);
  var memory = new Memory(4);
  var board = new Board(memory, canvas);
  board.draw();
}


