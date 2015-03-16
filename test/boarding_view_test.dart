import 'package:boarding/boarding.dart';
import 'dart:html';

main() {
  var canvas = querySelector('#canvas');
  drawCircle(canvas, 200, 200, 40, lineWidth: 2, color: 'black',
      borderColor: 'orange');
  drawCircleWithinSquare(canvas, 40, 420, 60, lineWidth: 4, color: 'blue');
  drawRect(canvas, 400, 300, 80, 40);
  drawRect(canvas, 100, 300, 40, 60, color: 'green');
  drawEllipseWithinRect(canvas, 400, 300, 80, 40, color: 'lightgreen');
  drawEllipseWithinRect(canvas, 320, 200, 80, 60, color: 'yellow', borderColor: 'blue');
  drawSquare(canvas, 40, 500, 60, lineWidth: 8, color: 'orange');
  drawSquare(canvas, 10, 30, 40, color: 'lightgray');
  drawSquare(canvas, 50, 190, 40, color: 'lightgreen');
  drawTriangleWithinSquare(canvas, 50, 190, 40);
  drawSelectedRect(canvas, 280, 380, 100, 50, color: 'lightgray');
  drawRoundedRect(canvas, 220, 310, 80, 40, lineWidth: 2, color: 'red');
  drawVehicle(canvas, 320, 90, 100, 40, color: 'brown');
  drawLine(canvas, 450, 380, 480, 560, lineWidth: 3, color: 'blue');
  drawTag(canvas, 320, 520, 32, 'Start on DArt', color: 'red');
  drawTag(canvas, 30, 50, 16, '4');
  drawStar(canvas, 100, 100, 30, innerRadius: 15, spikes: 5);
  drawSquare(canvas, 200, 200, 20);
  drawStarWithinSquare(canvas, 200, 200, 20, innerRadius: 5, spikes: 7,
      borderColor: 'red');
}