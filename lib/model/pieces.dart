part of boarding_model;

enum Form {CIRCLE, LINE, RECTANGLE, SQUARE, TAG}

abstract class Piece {
  static const Form defaultForm = Form.RECTANGLE;
  static const num widthLimit = 120;
  static const num heightLimit = 80;
  static const String defaultText = 'Dart';
  static const String defaultCode = '#000000';
  
  Form form = defaultForm; 
  num width = widthLimit;
  num height = heightLimit;
  String text = defaultText;
  String colorCode = defaultCode;
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
    var i = randomInt(5);
    switch (i) {
      case 0: form = Form.CIRCLE; break;
      case 1: form = Form.LINE; break;
      case 2: form = Form.RECTANGLE; break;
      case 3: form = Form.SQUARE; break;
      case 4: form = Form.TAG; 
    }
    width = randomNum(Piece.widthLimit);
    height = randomNum(Piece.widthLimit);
    text = randomListElement(colorList());
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
  
  randomInit() => forEach((MovingPiece mp) => mp.randomInit()); 
  onOff() => forEach((MovingPiece mp) => mp.onOff());
}

