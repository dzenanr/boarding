part of boarding_model;

abstract class Piece {
  static const num widthLimit = 120;
  static const num heightLimit = 80;
  static const String blackCode = '#000000';
  
  num width = widthLimit;
  num height = heightLimit;
  String colorCode = blackCode;
  num x = 0;
  num y = 0;
}

class MovingPiece extends Piece {
  static const num distanceLimitWidth = 800;
  static const num distanceLimitHeight = 600;
  static const num speedLimit = 6;
  
  num distanceWidth = distanceLimitWidth;
  num distanceHeight = distanceLimitHeight;
  num dx = 1;
  num dy = 1;
  bool movable = true;
  
  randomInit() {
    width = randomNum(Piece.widthLimit);
    height = randomNum(Piece.widthLimit);
    colorCode = randomColorCode();
    x = randomNum(distanceLimitWidth - width);
    y = randomNum(distanceLimitHeight - height);
    distanceWidth = randomNum(distanceLimitWidth);
    distanceHeight = randomNum(distanceLimitHeight);
    dx = randomNum(speedLimit);
    dy = randomNum(speedLimit);
  }

  move() { 
    if (movable) {
      x += dx;
      y += dy;
      if (x > distanceWidth || x < 0) dx = -dx;
      if (y > distanceHeight || y < 0) dy = -dy;      
    }
  }
  
  onOff() => movable = !movable;
}

abstract class Pieces {
  var _pieceList = new List();
  
  Iterator get iterator => _pieceList.iterator;
  int get length => _pieceList.length;
  add(Piece piece) => _pieceList.add(piece);
  forEach(Function f(Piece p)) => _pieceList.forEach(f);
}

class MovingPieces extends Pieces { 
  MovingPieces(int count) {
    for (var i = 0; i < count - 1; i++) {
      add(new MovingPiece());
    }
  }
  
  randomInit() => forEach((p) => p.randomInit()); 
  onOff() => forEach((p) => p.onOff());
}

