part of breakout;

class Ball extends MovablePiece {
  static const num defaultRadius = 10;
  
  num _radius;
  
  Ball() {
    shape = PieceShape.CIRCLE;
    radius = defaultRadius;
    color = 'yellow';
    borderColor = 'white';
  }
  
  num get radius => _radius;
  set radius(num r) {
    _radius = r;
    width = radius * 2;
    height = radius * 2;
  }
}

class Racket extends MovablePiece {
  static const num defaultWidth = 75;
  static const num defaultHeight = 10;
  
  Racket() {
    shape = PieceShape.RECT;
    width = defaultWidth;
    height = defaultHeight;
    color = 'white';
    borderColor = 'green';
  }
}