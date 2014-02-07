part of boarding;

class Circle {
  Surface surface;
  num x, y, radius;

  Circle(this.surface, this.x, this.y, this.radius);

  draw() {
    surface.context
        ..arc(x, y, radius, 0, PI * 2)
        ..stroke();
  }
}

class Rectangle {
  Surface surface;
  num x, y, width, height;

  Rectangle(this.surface, this.x, this.y, this.width, this.height);

  draw() {
    surface.context
        ..rect(x, y, width, height)
        ..stroke();
  }
}

class Square extends Rectangle {
  num length;

  Square(Surface surface, num x, num y, num l) :
    length = l, super(surface, x, y, l, l);
}

class Line {
  Surface surface;
  num x1, y1, x2, y2;

  Line(this.surface, this.x1, this.y1, this.x2, this.y2);

  draw() {
    surface.context
        ..moveTo(x1, y1)
        ..lineTo(x2, y2)
        ..stroke();
  }
}

class Text {
  Surface surface;
  String text;
  num size;     // in pixels
  String color;
  num x, y;

  Text(this.surface, this.text, this.size, this.color, this.x, this.y);

  draw() {
    surface.context
        ..font = 'bold ${size}px sans-serif'
        ..fillStyle = color
        ..fillText(text, x, y);
  }
}
