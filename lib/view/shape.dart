part of boarding;

class Circle {
  Surface surface;
  num x, y, radius, lineWidth;
  String inColor, outColor;

  Circle(this.surface, this.x, this.y, this.radius,
      {this.lineWidth: 1, this.inColor: 'white', this.outColor: 'black'});

  draw() {
    surface.context
        ..fillStyle = inColor
        ..arc(x, y, radius, 0, PI * 2)
        ..fill()
        ..lineWidth = lineWidth
        ..strokeStyle = outColor
        ..stroke();
  }
}

class Rectangle {
  Surface surface;
  num x, y, width, height, lineWidth;
  String inColor, outColor;

  Rectangle(this.surface, this.x, this.y, this.width, this.height,
      {this.lineWidth: 1, this.inColor: 'white', this.outColor: 'black'});

  draw() {
    surface.context
        ..fillStyle = inColor
        ..rect(x, y, width, height)
        ..fill()
        ..lineWidth = lineWidth
        ..strokeStyle = outColor
        ..stroke();
  }
}

class Square extends Rectangle {
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

  Line(this.surface, this.x1, this.y1, this.x2, this.y2,
      //{lineWidth: 1, color: 'black'});
      {color: 'black'});

  draw() {
    surface.context
        ..moveTo(x1, y1)
        ..lineTo(x2, y2)
        //..lineWidth = width
        ..strokeStyle = color
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
