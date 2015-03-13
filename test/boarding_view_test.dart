import 'package:boarding/boarding.dart';
import 'dart:html';

main() {
  var canvas = querySelector('#canvas');
  var circle = new Circle(canvas, 200, 200, 40, lineWidth: 4,
      color: 'yellow', borderColor: 'brown');
  circle.draw();
  var rectangle1 = new Rect(canvas, 400, 300, 80, 40);
  rectangle1.draw();
  var rectangle2 = new Rect(canvas, 100, 300, 40, 60, color: 'green');
  rectangle2.draw();
  var square1 = new Square(canvas, 40, 500, 60, lineWidth: 8, color: 'orange');
  square1.draw();
  var square2 = new Square(canvas, 10, 30, 40, color: 'lightgray');
  square2.draw();
  var selectedRect = new SelectedRect(canvas, 80, 380, 100, 50,
      color: 'lightgray');
  selectedRect.draw();
  var roundedRect = new RoundedRect(canvas, 280, 310, 80, 40, lineWidth: 2,
      color: 'red');
  roundedRect.draw();
  var line = new Line(canvas, 450, 380, 480, 560, lineWidth: 3, color: 'blue');
  line.draw();
  var tag1 = new Tag(canvas, 320, 520, 32, 'Start on DArt', color: 'red');
  tag1.draw();
  var tag2 = new Tag(canvas, 30, 50, 16, '4');
  tag2.draw();
  drawStar(canvas, 100, 100, 30, innerRadius: 15, spikes: 5);
  drawStar(canvas, 200, 200, 10,
      innerRadius: 5, spikes: 5, color: 'red', borderColor: 'blue');
  var star = new Star(canvas, 350, 250, 24);
  star.draw();
}