part of boarding;

class Circle {
  Surface surface;
  num x, y, radius, lineWidth;
  String inColor, outColor;

  Circle(this.surface, this.x, this.y, this.radius,
      {this.lineWidth: 1, this.inColor: 'white', this.outColor: 'black'});

  draw() {
    surface.context
        ..lineWidth = lineWidth
        ..fillStyle = inColor
        ..strokeStyle = outColor
        ..arc(x, y, radius, 0, PI * 2)
        ..fill()
        ..stroke();
  }
}

class Rect {
  Surface surface;
  num x, y, width, height, lineWidth;
  String inColor, outColor;

  Rect(this.surface, this.x, this.y, this.width, this.height,
      {this.lineWidth: 1, this.inColor: 'white', this.outColor: 'black'});

  draw() {
    surface.context
        ..lineWidth = lineWidth
        ..fillStyle = inColor
        ..strokeStyle = outColor
        ..rect(x, y, width, height)
        ..fill()
        ..stroke();
  }
}

class Square extends Rect {
  num length;

  Square(Surface surface, num x, num y, num l,
      {lineWidth: 1, inColor: 'white', outColor: 'black'}) : length = l,
      super(surface, x, y, l, l, lineWidth: lineWidth,
          inColor: inColor, outColor: outColor);
}

class Line {
  Surface surface;
  num x1, y1, x2, y2;
  //num width; // named optional param gives an errorG!?
  String color;

  Line(this.surface, this.x1, this.y1, this.x2, this.y2, {color: 'black'});
       //{width: 1, color: 'black'});

  draw() {
    surface.context
        //..lineWidth = width
        ..strokeStyle = color
        ..moveTo(x1, y1)
        ..lineTo(x2, y2)
        ..stroke();
  }
}

class Text {
  Surface surface;
  String text;
  num x, y;
  num size;     // in pixels
  String color;

  Text(this.surface, this.text, this.x, this.y,
      {this.size: 12, this.color: 'black'});

  draw() {
    surface.context
        ..font = 'bold ${size}px sans-serif'
        ..fillStyle = color
        ..fillText(text, x, y);
  }
}
