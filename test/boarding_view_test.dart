import 'package:boarding/boarding_model.dart';
import 'package:boarding/boarding.dart';
import 'dart:html';

main() {
  // model
  var grid = new Grid(2, 4);
  // view
  var canvas = querySelector('#canvas');
  var surface = new Surface(grid, canvas, withLines: false);
  surface.draw();
  var circle1 = new Circle(surface, 200, 200, 40, lineWidth: 4, color: 'yellow', borderColor: 'brown');
  circle1.draw();
  var rectangle1 = new Rect(surface, 400, 300, 80, 40);
  rectangle1.draw();
  var rectangle2 = new Rect(surface, 100, 300, 40, 60, color: 'green');
  rectangle2.draw();
  var square1 = new Square(surface, 40, 500, 60, lineWidth: 8, color: 'orange');
  square1.draw();
  var line1 = new Line(surface, 450, 380, 480, 560, lineWidth: 3, color: 'blue');
  line1.draw();
  var tag1 = new Tag(surface, 320, 520, 32, 'Start on DArt', color: 'red');
  tag1.draw();
}