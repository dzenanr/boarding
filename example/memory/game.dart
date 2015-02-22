library memory;

import 'dart:async';
import 'dart:html';
import 'package:boarding/grids.dart';
import 'package:boarding/boarding.dart';
import 'package:boarding/util.dart';

part 'model/memory.dart';
part 'view/board.dart';

playAgain(Event e) {
  window.location.reload();
}

main() {
  new Board(querySelector('#canvas'), new Memory(4)).draw();
  querySelector('#play').onClick.listen(playAgain);
}


