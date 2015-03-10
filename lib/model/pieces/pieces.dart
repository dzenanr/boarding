part of pieces;

enum PieceShape {CIRCLE, LINE, RECT, ROUNDED_RECT, SELECTED_RECT, SQUARE, TAG, VEHICLE}

abstract class Piece {
  static const PieceShape defaultShape = PieceShape.RECT;
  static const num widthMin = 12;
  static const num heightMin = 8;
  static const num widthMax = 120;
  static const num heightMax = 80;
  static const String defaultText = 'Dart';
  static const String defaultCode = '#000000';
 
  int id;
  PieceShape shape = defaultShape;
  num x = 0;
  num y = 0;
  num width = widthMax;
  num height = heightMax;
  String text = defaultText;
  String colorCode = defaultCode;
  bool isVisible = true;
  bool isSelected = false;
  
  Piece(this.id);
  
  fromJsonMap(Map<String, Object> jsonMap) {
    id  = jsonMap['id'];
    shape = PieceShape.values[jsonMap['index']];
    x = jsonMap['x'];
    y = jsonMap['y'];
    width = jsonMap['width'];
    height = jsonMap['height'];
    text = jsonMap['text'];
    colorCode = jsonMap['colorCode'];
    isVisible = jsonMap['isVisible'];
    isSelected = jsonMap['isSelected'];
  }
  
  fromJsonString(String jsonString) {
    Map<String, Object> jsonMap = JSON.decode(jsonString);
    fromJsonMap(jsonMap);
  }
  
  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
    jsonMap['id'] = id;
    jsonMap['index'] = shape.index;
    jsonMap['x'] = x;
    jsonMap['y'] = y;
    jsonMap['width'] = width;
    jsonMap['height'] = height;
    jsonMap['text'] = text;
    jsonMap['colorCode'] = colorCode;
    jsonMap['isVisible'] = isVisible;
    jsonMap['isSelected'] = isSelected;
    return jsonMap;
  }
  
  String toJsonString() => JSON.encode(toJsonMap());
  
  bool contains(num xx, num yy) => ((xx >= x && xx <= x + width) && (yy >= y && yy <= y + height));
}

class MovablePiece extends Piece {
  static const num distanceLimitMinWidth = 600;
  static const num distanceLimitMaxWidth = 800;
  static const num distanceLimitMinHeight = 400;
  static const num distanceLimitMaxHeight = 600;
  static const num speedLimit = 6;
  
  num distanceMinWidth = distanceLimitMinWidth;
  num distanceMaxWidth = distanceLimitMaxWidth;
  num distanceMinHeight = distanceLimitMinHeight;
  num distanceMaxHeight = distanceLimitMaxHeight;
  num speed = speedLimit;
  num dx = 1;
  num dy = 1;
  bool isMoving = true;
  
  MovablePiece(int id): super(id);
  
  fromJsonMap(Map<String, Object> jsonMap) {
    super.fromJsonMap(jsonMap);
    distanceMinWidth = jsonMap['distanceMinWidth'];
    distanceMaxWidth = jsonMap['distanceMaxWidth'];
    distanceMinHeight = jsonMap['distanceMinHeight'];
    distanceMaxHeight = jsonMap['distanceMaxHeight'];
    speed = jsonMap['speed'];
    dx = jsonMap['dx'];
    dy = jsonMap['dy'];
    isMoving = jsonMap['isMoving'];
  }
  
  Map<String, Object> toJsonMap() {
    var jsonMap = super.toJsonMap();
    jsonMap['distanceMinWidth'] = distanceMinWidth;
    jsonMap['distanceMaxWidth'] = distanceMaxWidth;
    jsonMap['distanceMinHeight'] = distanceMinHeight;
    jsonMap['distanceMaxHeight'] = distanceMaxHeight;
    jsonMap['speed'] = speed;
    jsonMap['dx'] = dx;
    jsonMap['dy'] = dy;
    jsonMap['isMoving'] = isMoving;
    return jsonMap;
  }

  randomInit() {
    var i = randomInt(PieceShape.values.length);
    shape = PieceShape.values[i];
    width = randomRangeNum(Piece.widthMin, Piece.widthMax);
    height = randomRangeNum(Piece.heightMin, Piece.heightMax);
    speed = randomNum(6) + 1;
    text = randomElement(colorList());
    colorCode = colorMap()[text];
    x = randomNum(distanceLimitMaxWidth - width);
    y = randomNum(distanceLimitMaxHeight - height);
    distanceMaxWidth = randomRangeNum(distanceLimitMinWidth, distanceLimitMaxWidth);
    distanceMaxHeight = randomRangeNum(distanceLimitMinHeight, distanceLimitMaxHeight);
    dx = randomNum(speedLimit);
    dy = randomNum(speedLimit);
  }
  
  move([Direction direction]) {
    if (isMoving) {
      if (direction == null) {
        x += dx;
        y += dy;
        if (x > distanceMaxWidth || x < 0) dx = -dx;
        if (y > distanceMaxHeight || y < 0) dy = -dy; 
      } else {
        switch(direction) {
          case Direction.UP:
            y -= dy;
            if (y < 0) {
              x = randomNum(distanceMinWidth);
              y = randomRangeNum(distanceMinHeight, distanceMaxHeight);
            }
            break;
          case Direction.DOWN:
            y += dy; 
            if (y > distanceMaxHeight) {
              x = randomNum(distanceMinWidth);
              y = -randomRangeNum(distanceMinHeight, distanceMaxHeight);
            }
            break;
          case Direction.LEFT:
            x -= dx; 
            if (x < 0) {
              x = randomRangeNum(distanceMinWidth, distanceMaxWidth);
              y = randomNum(distanceMinHeight);
            }
            break;
          case Direction.RIGHT:
            x += dx;
            if (x > distanceMaxWidth) {
              x = -randomRangeNum(distanceMinWidth, distanceMaxWidth);
              y = randomNum(distanceMinHeight);
            } 
        } 
      }
    }
  }
  
  onOff() => isMoving = !isMoving;
  
  bool hit(Piece p) {
    bool isHit = false;
    if (p.x < x  && p.y < y) {
      if (p.x + p.width >= x && p.y + p.height >= y) {
        isHit = true;
      }
    } else if (p.x > x  && p.y < y) {
      if (p.x <= x + width && p.y + p.height >= y) {
        isHit = true;
      }
    } else if (p.x < x  && p.y > y) {
      if (p.x + p.width >= x && p.y <= y + height) {
        isHit = true;
      }
    } else if (p.x > x  && p.y > y) {
      if (p.x <= x + width && p.y <= y + height) {
        isHit = true;
      }
    }
    return isHit;
  }
  
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
  
  fromJsonList(List<Map<String, Object>> jsonList) {
    jsonList.forEach((jsonMap) {
      var p = piece(jsonMap['id']);
      if (p != null) {
        p.fromJsonMap(jsonMap);
      } 
    });
  }
  
  fromJsonString(String jsonString) {
    List<Map<String, Object>> jsonList = JSON.decode(jsonString);
    fromJsonList(jsonList);
  }
  
  List<Map<String, Object>> toJsonList() {
    var jsonList = new List<Map<String, Object>>();
    forEach((Piece p) => jsonList.add(p.toJsonMap()));
    return jsonList;
  }
  
  String toJsonString() => JSON.encode(toJsonList());
  
  Iterator get iterator => _pieceList.iterator;
  int get length => _pieceList.length;
  add(Piece piece) => _pieceList.add(piece);
  forEach(Function f(Piece p)) => _pieceList.forEach(f);
  bool any(bool f(Piece p)) => _pieceList.any(f);
  bool every(bool f(Piece p)) => _pieceList.every(f);
  
  int invisibleCount() {
    int count = 0;
    for (Piece p in this) {
      if (!p.isVisible) {
        count++;
      }
    }
    return count;
  }
  
  Piece piece(int id) {
    for (Piece p in this) {
      if (p.id == id) return p;
    }
    return null;
  }
}

class MovablePieces extends Pieces { 
  
  MovablePieces(int count) {
    createMovablePieces(count);
  }
  
  createMovablePieces(int count) {
    var id = 0;
    for (var i = 0; i < count; i++) {
      add(new MovablePiece(++id));
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

