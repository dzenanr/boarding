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
  var circle1 = new Circle(surface, x: 200, y:200, width: 80, lineWidth: 4, color: 'yellow', borderColor: 'brown');
  circle1.draw();
  var rectangle1 = new Rect(surface, x: 400, y: 300, width: 80, height: 40);
  rectangle1.draw();
  var rectangle2 = new Rect(surface, x: 100, y: 300, width: 40, height: 60, color: 'green');
  rectangle2.draw();
  var square1 = new Square(surface, x: 40, y: 500, width: 60, lineWidth: 8, color: 'orange');
  square1.draw();
  var line1 = new Line(surface, x: 450, y: 380, width: 480, height: 560, lineWidth: 3, color: 'blue');
  line1.draw();
  var tag1 = new Tag(surface, x: 320, y: 520, width: 32, text: 'Start on DArt', color: 'red');
  tag1.draw();
}