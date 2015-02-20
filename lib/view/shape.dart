part of boarding;

abstract class Shape {
  Surface surface;
  num x, y, width, height, lineWidth;
  String color, borderColor;
  
  Shape(this.surface, this.x, this.y, this.width, this.height, 
      this.lineWidth, this.color, this.borderColor);
  
  draw();
}

class Circle extends Shape {
  Circle(Surface surface, 
      {num x, num y, num width, 
       num lineWidth: 1, String color: 'white', String borderColor: 'black'}):
      super(surface, x, y, width, width, lineWidth, color, borderColor);

  draw() {
    surface.context
        ..lineWidth = lineWidth
        ..fillStyle = color
        ..strokeStyle = borderColor
        ..beginPath()
        ..arc(x, y, width / 2, 0, PI * 2)
        ..closePath()
        ..fill()
        ..stroke();
  }
}

class Rect extends Shape {
  Rect(Surface surface, 
       {num x, num y, num width, num height, 
        num lineWidth: 1, String color: 'white', String borderColor: 'black'}):
       super(surface, x, y, width, height, lineWidth, color, borderColor);

  draw() {
    surface.context
        ..lineWidth = lineWidth
        ..fillStyle = color
        ..strokeStyle = borderColor
        ..beginPath()
        ..rect(x, y, width, height)
        ..closePath()
        ..fill()
        ..stroke();
  }
}

class Square extends Rect {
  Square(Surface surface, 
      {num x, num y, num width,
       num lineWidth: 1, String color: 'white', String borderColor: 'black'}):
      super(surface, x: x, y: y, width: width, height: width, lineWidth: lineWidth, color: color, borderColor: borderColor);
}

class Line extends Shape {
  Line(Surface surface, 
      {num x, num y, num width, num height,  
       num lineWidth: 1, String color: 'black', String borderColor: 'black'}):
      super(surface, x, y, width, height, lineWidth, color, borderColor);

  draw() {
    surface.context
        ..lineWidth = lineWidth
        ..strokeStyle = color
        ..beginPath()
        ..moveTo(x, y)
        ..lineTo(width, height)
        ..closePath()
        ..stroke();
  }
}

class Tag extends Shape {
  String text;

  Tag(Surface surface, 
      {num x, num y, num width, this.text,
       num lineWidth: 1, String color: 'black', String borderColor: 'black'}):
      super(surface, x, y, width, width, width, color, borderColor);

  draw() {
    surface.context
        ..font = 'bold ${width}px sans-serif'
        ..fillStyle = color
        ..beginPath()
        ..fillText(text, x, y)
        ..closePath();
  }
}
