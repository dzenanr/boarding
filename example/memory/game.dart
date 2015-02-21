library memory;

import 'dart:async';
import 'dart:html';
import 'package:boarding/boarding_model.dart';
import 'package:boarding/boarding.dart';

part 'model/memory.dart';
part 'view/board.dart';

playAgain(Event e) {
  window.location.reload();
}

main() {
  new Board(querySelector('#canvas'), new Memory(4)).draw();
  querySelector('#play').onClick.listen(playAgain);
}


