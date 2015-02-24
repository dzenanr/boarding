import 'package:boarding/grids.dart';
import 'package:boarding/boarding.dart';
import 'dart:html';

main() {
  // model
  var grid = new Grid(2, 4);
  // view
  var canvas = querySelector('#canvas');
  var surface = new Surface(canvas, withLines: false, grid: grid);
  surface.draw();
  var circle1 = new Circle(surface, 200, 200, 40, lineWidth: 4, color: 'yellow', borderColor: 'brown');
  circle1.draw();
  var rectangle1 = new Rect(surface, 400, 300, 80, 40);
  rectangle1.draw();
  var rectangle2 = new Rect(surface, 100, 300, 40, 60, color: 'green');
  rectangle2.draw();
  var square = new Square(surface, 40, 500, 60, lineWidth: 8, color: 'orange');
  square.draw();
  var roundedRect = new RoundedRect(surface, 280, 310, 80, 40, lineWidth: 2, color: 'red');
  roundedRect.draw();
  var line = new Line(surface, 450, 380, 480, 560, lineWidth: 3, color: 'blue');
  line.draw();
  var tag = new Tag(surface, 320, 520, 32, 'Start on DArt', color: 'red');
  tag.draw();
}