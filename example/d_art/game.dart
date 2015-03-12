library d_art;

import 'dart:html';
import 'package:boarding/art_pen.dart' as d_pen;
import 'package:boarding/boarding.dart' as shape;
import 'package:boarding/util.dart' as util;

part 'view/board.dart';

/*
var basicCommands = ['color', 'width', 'down', 'write', 'moveTo', 'move', 'art'];
var shortcutCommands = ['left', 'right', 'backward', 'forward', 'moveToStart'];
var commands = ['color',
                'width',
                'down',
                'write',
                'moveToStart',
                'moveTo',
                'move',
                'left',
                'right',
                'backward',
                'forward',
                'art'
               ];
var randomCommands = [
                      'colorRandom',
                      'widthRandom',
                      'downRandom',
                      'moveToRandom',
                      'moveRandom',
                      'leftRandom',
                      'rightRandom',
                      'backwardRandom',
                      'forwardRandom',
                      'artRandom'
                     ];
*/

onako(d_pen.Pen pen) {
  var tako = '''
move, 177, 200, 11;
art, 4;
  ''';
  pen.interpret(tako);
}

rotateSquare(d_pen.Pen pen) {
  square() {
    pen.move(90, 100, 3);
  }

  pen.erase();
  for (var k = 0; k < 52; k++) {
    pen.colorRandom();
    square();
    pen.right(10);
  }
}

stairSquare(d_pen.Pen pen, {num size: 60}) {
  multicolorSquare(var size) {
    for (var color in ['blue', 'gray', 'red', 'yellow']) {
      pen.color = color;
      pen.forward(size);
      pen.left(90);
    }
  }
  pen.erase();
  pen.width = 2;
  for (var i in new List(16)) {
    multicolorSquare(size);
    size = size + 10;
    pen.forward(10);
    pen.right(18);
  }
}

barGraph(d_pen.Pen pen) {
  pen.erase();
  pen.color = 'blue';
  pen.left(90);
  pen.forward(100);
  pen.write = 'a';
  pen.right(90);
  pen.forward(30);
  pen.write = '';
  pen.right(90);
  pen.forward(100);
  pen.color = 'black';
  pen.left(90);
  pen.forward(30);
  pen.color = 'red';
  pen.left(90);
  pen.forward(80);
  pen.write = 'b';
  pen.right(90);
  pen.forward(30);
  pen.write = '';
  pen.right(90);
  pen.forward(80);
  pen.color = 'black';
  pen.left(90);
  pen.forward(30);
  pen.color = 'green';
  pen.left(90);
  pen.forward(140);
  pen.write = 'c';
  pen.right(90);
  pen.forward(30);
  pen.write = '';
  pen.right(90);
  pen.forward(140);
  pen.color = 'black';
  pen.left(90);
}

mapMap(d_pen.Pen pen) {
  zig(int level) {
    pen.forward(level * 30);
    var l = level - 1;
    if (l > 0) {
      pen.left(45);
      for (var i = 0; i < 3; i++) {
        pen.colorRandom();
        zig(l);
        pen.right(90);
        pen.forward(level * i);
      }
    }
  }

  pen.erase();
  zig(6);
}

zigZag(d_pen.Pen pen) {
  f(var length, var depth) {
    if (depth == 0) {
      pen.forward(length);
    } else {
      f(length / 3, depth - 1);
      pen.right(60);
      f(length / 3, depth - 1);
      pen.left(120);
      f(length / 3, depth - 1);
      pen.right(60);
      f(length / 3, depth - 1);
    }
  }
  pen.erase();
  f(240, 4);
}

runRandom(d_pen.Pen pen) {
  //d_pen.randomProgram(pen);
  d_pen.randomSequence(pen);
  //d_pen.randomExample(pen);
  //d_pen.randomDemo(pen);
}

runProgram(d_pen.Pen pen) {
  //onako(pen);
  //rotateSquare(pen);
  //stairSquare(pen);
  //barGraph(pen);
  //mapMap(pen);
  zigZag(pen);
}

main() {
  final repo = new d_pen.ArtRepo();
  final board = new Board(querySelector('#canvas'), repo);
  var pen = board.pen;
  runRandom(pen);
  //runProgram(pen);
  board.draw();
  pen.displayCommands();
}