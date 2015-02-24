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
  num radius; 
  
  Circle(Surface surface, num x, num y, this.radius, 
      {num lineWidth: 1, String color: 'white', String borderColor: 'black'}): 
      super(surface, x, y, null, null, lineWidth, color, borderColor) {
    width = radius * 2;
    height = radius * 2;
  }

  draw() {
    surface.context
        ..lineWidth = lineWidth
        ..fillStyle = color
        ..strokeStyle = borderColor
        ..beginPath()
        ..arc(x, y, radius, 0, PI * 2)
        ..closePath()
        ..fill()
        ..stroke();
  }
}

class Rect extends Shape {
  Rect(Surface surface, num x, num y, num width, num height, 
       {num lineWidth: 1, String color: 'white', String borderColor: 'black'}):
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
  num length;
  
  Square(Surface surface, num x, num y, num width,
      {num lineWidth: 1, String color: 'white', String borderColor: 'black'}):
      length = width,
      super(surface, x, y, width, width, lineWidth: lineWidth, color: color, borderColor: borderColor);
}

prepareRoundedRect(Surface surface, num x, num y, num width, num height, num radius) {
  // http://stackoverflow.com/questions/1255512/how-to-draw-a-rounded-rectangle-on-html-canvas
  var r2d = PI/180;
  //ensure that the radius isn't too large for x
  if ((width - x) - (2 * radius) < 0) {radius = (( width - x ) / 2);}
  //ensure that the radius isn't too large for y
  if ((height - y) - (2 * radius) < 0 ) {radius = ((height - y) / 2 );}
  surface.context
    ..beginPath()
    ..moveTo(x + radius, y)
    ..lineTo(width - radius, y)
    ..arc(width - radius, y + radius, radius, r2d * 270, r2d * 360, false)
    ..lineTo(width, height - radius)
    ..arc(width - radius, height - radius, radius, r2d * 0, r2d * 90, false)
    ..lineTo(x + radius, height)
    ..arc(x + radius, height - radius, radius, r2d * 90, r2d * 180, false)
    ..lineTo(x, y + radius)
    ..arc(x + radius, y + radius, radius, r2d * 180, r2d * 270, false)
    ..closePath();
}
  
class RoundedRect extends Rect {
  num radius;
  num r2d = PI/180;
  
  RoundedRect(Surface surface, num x, num y, num width, num height, 
      {num this.radius: 10, num lineWidth: 1, String color: 'white', String borderColor: 'black'}):
      super(surface, x, y, width, height, lineWidth: lineWidth, color: color, borderColor: borderColor);
  
  draw() {
    prepareRoundedRect(surface, x, y, x + width, y + height, 10);
    surface.context
      ..lineWidth = lineWidth
      ..fillStyle = color
      ..strokeStyle = borderColor
      ..fill()
      ..stroke();
  }
}

class Line extends Shape {
  num x1, y1;
  
  Line(Surface surface, num x, num y, this.x1, this.y1,  
      {num lineWidth: 1, String color: 'black', String borderColor: 'black'}):
      super(surface, x, y, lineWidth, null, lineWidth, color, borderColor);

  draw() {
    surface.context
        ..lineWidth = lineWidth
        ..strokeStyle = color
        ..beginPath()
        ..moveTo(x, y)
        ..lineTo(x1, y1)
        ..closePath()
        ..stroke();
  }
}

class OneOfLines extends Shape {
  num x1, y1;
  
  OneOfLines(Surface surface, num x, num y, this.x1, this.y1,  
      {num lineWidth: 1, String color: 'black', String borderColor: 'black'}):
      super(surface, x, y, lineWidth, null, lineWidth, color, borderColor);

  draw() {
    surface.context
        ..lineWidth = lineWidth
        ..strokeStyle = color
        ..moveTo(x, y)
        ..lineTo(x1, y1);
  }
}

class Tag extends Shape {
  num size, maxWidth;
  String text;

  Tag(Surface surface, num x, num y, this.size, this.text, 
      {num lineWidth: 1, num this.maxWidth, String color: 'black', String borderColor: 'black'}):
      super(surface, x, y, null, null, lineWidth, color, borderColor) {
    this.width = size;
    this.height = size;
  }

  draw() {
    surface.context
        ..font = '${size}px sans-serif'
        ..fillStyle = color
        ..textAlign = 'center'
        ..beginPath()
        ..fillText(text, x, y)
        ..closePath();
  }
}

class OneOfTags extends Shape {
  num size, maxWidth;
  String text;

  OneOfTags(Surface surface, num x, num y, this.size, this.text, 
      {num lineWidth: 1, num this.maxWidth, String color: 'black', String borderColor: 'black'}):
      super(surface, x, y, null, null, lineWidth, color, borderColor) {
    this.width = size;
    this.height = size;
  }

  draw() {
    surface.context
        ..font = '${size}px sans-serif'
        ..fillStyle = color
        ..textAlign = 'center'
        ..fillText(text, x, y, maxWidth);
  }
}
