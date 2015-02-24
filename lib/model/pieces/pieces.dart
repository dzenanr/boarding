part of pieces;

enum PieceShape {CIRCLE, LINE, RECTANGLE, SQUARE, TAG}

abstract class Piece {
  static const PieceShape defaultShape = PieceShape.RECTANGLE;
  static const num widthLimit = 120;
  static const num heightLimit = 80;
  static const String defaultText = 'Dart';
  static const String defaultCode = '#000000';
  
  PieceShape shape = defaultShape; 
  num width = widthLimit;
  num height = heightLimit;
  String text = defaultText;
  String colorCode = defaultCode;
  bool isVisible = true;
  bool isSelected = false;
  bool contains(num xx, num yy) {
    if ((xx > x && xx < x + width) && (yy > y && yy < y + height)) {
      return true;
    }
    else {
      return false;
    }
  }
  num x = 0;
  num y = 0;
}

class FallingPiece extends Piece {
  static const num distanceLimit = 600;
  
  num distanceHeight = distanceLimit;
  var shape = PieceShape.RECTANGLE;
  bool toReappear = true;
  num dy = 2;
  
  randomInit() {
    height = randomNum(Piece.heightLimit);
    width = height;
    colorCode = randomColorCode();
    x = randomNum(distanceLimit - width);
    y = -randomNum(distanceHeight - height);
  }
  
  move() { 
    y += dy;
    if (y >= distanceHeight) {
      toReappear = true;
    } else {
      toReappear = false;
    }
    if (toReappear) {
      var r = randomNum(distanceHeight);
      y = -r;
      x = r;
    }
  }
}

class MovablePiece extends Piece {
  static const num distanceLimitWidth = 800;
  static const num distanceLimitHeight = 600;
  static const num speedLimit = 6;
  
  num distanceWidth = distanceLimitWidth;
  num distanceHeight = distanceLimitHeight;
  num speed = speedLimit;
  num dx = 1;
  num dy = 1;
  bool isMoving = true;
  
  randomInit() {
    var i = randomInt(5);
    switch (i) {
      case 0: shape = PieceShape.CIRCLE; break;
      case 1: shape = PieceShape.LINE; break;
      case 2: shape = PieceShape.RECTANGLE; break;
      case 3: shape = PieceShape.SQUARE; break;
      case 4: shape = PieceShape.TAG; 
    }
    width = randomNum(Piece.widthLimit);
    height = randomNum(Piece.heightLimit);
    speed = randomNum(6) + 1;
    text = randomElement(colorList());
    //colorCode = randomColorCode();
    colorCode = colorMap()[text];
    x = randomNum(distanceLimitWidth - width);
    y = randomNum(distanceLimitHeight - height);
    distanceWidth = randomNum(distanceLimitWidth);
    distanceHeight = randomNum(distanceLimitHeight);
    dx = randomNum(speedLimit);
    dy = randomNum(speedLimit);
  }

  move() { 
    if (isMoving) {
      x += dx;
      y += dy;
      if (x > distanceWidth || x < 0) dx = -dx;
      if (y > distanceHeight || y < 0) dy = -dy;      
    }
  }
  
  onOff() => isMoving = !isMoving;
  
  avoidCollision(Piece p) {
    if (p.x < x  && p.y < y) {
      if (p.x + p.width >= x && p.y + p.height >= y) {
        dx = -dx; dy = -dy;
      }
    } else if (p.x > x  && p.y < y) {
      if (p.x <= x + width && p.y + p.height >= y) {
        dx = -dx; dy = -dy;
      }
    } else if (p.x < x  && p.y > y) {
      if (p.x + p.width >= x && p.y <= y + height) {
        dx = -dx; dy = -dy;
      }
    } else if (p.x > x  && p.y > y) {
      if (p.x <= x + width && p.y <= y + height) {
        dx = -dx; dy = -dy;
      }
    }
  }
}

abstract class Pieces {
  var _pieceList = new List();
  
  Iterator get iterator => _pieceList.iterator;
  int get length => _pieceList.length;
  add(Piece piece) => _pieceList.add(piece);
  forEach(Function f(Piece p)) => _pieceList.forEach(f);
}

class FallingPieces extends Pieces { 
  FallingPieces(int count) {
    createFallingPieces(count);
  }
  
  createFallingPieces(int count) {
    for (var i = 0; i < count; i++) {
      add(new FallingPiece());
    }
  }
  
  randomInit() => forEach((FallingPiece fp) => fp.randomInit()); 
}

class MovablePieces extends Pieces { 
  MovablePieces(int count) {
    createMovablePieces(count);
  }
  
  createMovablePieces(int count) {
    for (var i = 0; i < count; i++) {
      add(new MovablePiece());
    }
  }
  
  randomInit() => forEach((MovablePiece mp) => mp.randomInit()); 
  onOff() => forEach((MovablePiece mp) => mp.onOff());
  
  avoidCollisions(MovablePiece mp) {
    for (var p in this) {
      if (p != mp) {
        mp.avoidCollision(p);
      }
    }
  }
}

