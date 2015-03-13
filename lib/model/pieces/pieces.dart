part of pieces;

enum PieceShape {CIRCLE, LINE, RECT, ROUNDED_RECT, SELECTED_RECT, SQUARE, TAG, VEHICLE}

num distance(Piece p1, Piece p2) { // in pixels
  var xd = p1.x - p2.x, yd = p1.y - p2.y;
  return sqrt(xd * xd + yd * yd);
}

accelerate(MovablePiece p1, MovablePiece p2, {num coefficient: 2000}) {
  // Some acceleration depending upon distance.
  var xd = p1.x - p2.x, yd = p1.y - p2.y;
  var ax = xd / coefficient, ay = yd / coefficient;
  // Apply the acceleration.
  p1.dx -= ax; p1.dy -= ay;
  p2.dx += ax; p2.dy += ay;
}

class Dimension {
  static const num limitMinWidth = 12;
  static const num limitMaxWidth = 120;
  static const num limitMinHeight = 8;
  static const num limitMaxHeight = 80;

  num minWidth = limitMinWidth;
  num maxWidth = limitMaxWidth;
  num minHeight = limitMinHeight;
  num maxHeight = limitMaxHeight;

  num width = limitMaxWidth;
  num height = limitMaxHeight;

  Dimension();

  Dimension.from(num width, num height) {
    minWidth = width;
    maxWidth = width;
    minHeight = height;
    maxHeight = height;
    this.width = width;
    this.height = height;
  }

  Dimension.fromJsonMap(Map<String, num> jsonMap) {
    minWidth = jsonMap['minWidth'];
    maxWidth = jsonMap['maxWidth'];
    minHeight = jsonMap['minHeight'];
    maxHeight = jsonMap['maxHeight'];
    width = jsonMap['width'];
    height = jsonMap['height'];
  }

  Map<String, num> toJsonMap() {
    var jsonMap = new Map<String, num>();
    jsonMap['minWidth'] = minWidth;
    jsonMap['maxWidth'] = maxWidth;
    jsonMap['minHeight'] = minHeight;
    jsonMap['maxHeight'] = maxHeight;
    jsonMap['width'] = width;
    jsonMap['height'] = height;
    return jsonMap;
  }

  random() {
    width = randomRangeNum(minWidth, maxWidth);
    height = randomRangeNum(minHeight, maxHeight);
  }

  bool isMinMaxWidthSame() => minWidth == maxWidth && maxWidth == width;
  bool isMinMaxHeightSame() => minHeight == maxHeight && maxHeight == height;
}

class Distance extends Dimension {
  static const num limitMinWidth = 600;
  static const num limitMaxWidth = 800;
  static const num limitMinHeight = 400;
  static const num limitMaxHeight = 600;

  num minWidth = limitMinWidth;
  num maxWidth = limitMaxWidth;
  num minHeight = limitMinHeight;
  num maxHeight = limitMaxHeight;

  num width = limitMaxWidth;
  num height = limitMaxHeight;

  Distance();

  Distance.from(num width, num height): super.from(width, height);

  Distance.fromJsonMap(Map<String, num> jsonMap): super.fromJsonMap(jsonMap);
}

class Piece {
  static const PieceShape defaultShape = PieceShape.RECT;
  static const String defaultText = 'Dart';
  static const String defaultColor = '#000000'; // black

  int id;
  PieceShape shape = defaultShape;
  num x = 0;
  num y = 0;
  Dimension dimension = new Dimension();
  String text = defaultText;
  String color = defaultColor;
  String borderColor = defaultColor;
  bool isVisible = true;
  bool isSelected = false;

  Piece(this.id);

  num get width => dimension.width;
  set width(num width) => dimension.width = width;
  num get height => dimension.height;
  set height(num height) => dimension.height = height;

  fromJsonMap(Map<String, Object> jsonMap) {
    id  = jsonMap['id'];
    shape = PieceShape.values[jsonMap['index']];
    x = jsonMap['x'];
    y = jsonMap['y'];
    dimension = new Dimension.fromJsonMap(jsonMap['dimension']);
    text = jsonMap['text'];
    color = jsonMap['color'];
    borderColor = jsonMap['borderColor'];
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
    jsonMap['dimension'] = dimension.toJsonMap();
    jsonMap['text'] = text;
    jsonMap['color'] = color;
    jsonMap['borderColor'] = borderColor;
    jsonMap['isVisible'] = isVisible;
    jsonMap['isSelected'] = isSelected;
    return jsonMap;
  }

  String toJsonString() => JSON.encode(toJsonMap());

  randomInit() {
    var i = randomInt(PieceShape.values.length);
    shape = PieceShape.values[i];
    dimension.random();
    text = randomElement(colorList());
    color = colorMap()[text];
  }

  bool contains(num xx, num yy) =>
      ((xx >= x && xx <= x + width) && (yy >= y && yy <= y + height));
}

class MovablePiece extends Piece {
  static const num speedLimit = 6;

  Distance _distance;
  num dx = 1;
  num dy = 1;
  bool isMoving = true;

  MovablePiece(int id, [Distance distance]): super(id) {
    if (distance == null) {
      _distance =  new Distance();
    } else {
      _distance = distance;
    }
  }

  num get speed => max(dx, dy);

  Distance get distance => _distance;
  set distance(Distance distance) {
    if (distance != null) {
      _distance = distance;
      if (shape == PieceShape.CIRCLE) {
        if (x + width / 2 > distance.width) {
          x = distance.width - width / 2;
        }
        if (y + height / 2 > distance.height) {
          y = distance.height - height / 2;
        }
      } else {
        if (x + width > distance.width) {
          x = distance.width - width;
        }
        if (y + height > distance.height) {
          y = distance.height - height;
        }
      }
    }
  }

  fromJsonMap(Map<String, Object> jsonMap) {
    super.fromJsonMap(jsonMap);
    distance = new Distance.fromJsonMap(jsonMap['distance']);
    dx = jsonMap['dx'];
    dy = jsonMap['dy'];
    isMoving = jsonMap['isMoving'];
  }

  Map<String, Object> toJsonMap() {
    var jsonMap = super.toJsonMap();
    jsonMap['distance'] = distance.toJsonMap();
    jsonMap['dx'] = dx;
    jsonMap['dy'] = dy;
    jsonMap['isMoving'] = isMoving;
    return jsonMap;
  }

  randomInit() {
    super.randomInit();
    randomPosition();
    dx = randomNum(speedLimit);
    dy = randomNum(speedLimit);
  }

  randomPosition() {
    distance.random();
    if (shape == PieceShape.CIRCLE) {
      x = randomNum(distance.width - width / 2);
      y = randomNum(distance.height - height / 2);
    } else {
      x = randomNum(distance.width - width);
      y = randomNum(distance.height - height);
    }
  }

  move([Direction direction]) {
    if (isMoving) {
      if (direction == null) {
        x += dx;
        y += dy;
        if (shape == PieceShape.CIRCLE) {
          if (x + width / 2 > distance.width || x - width / 2 < 0) {
            dx = -dx;
          }
          if (y + height / 2 > distance.height || y - height / 2 < 0) {
            dy = -dy;
          }
        } else {
          if (x > distance.width - width || x < 0) {
            dx = -dx;
          }
          if (y > distance.height - height || y < 0) {
            dy = -dy;
          }
        }
      } else {
        switch(direction) {
          case Direction.UP:
            y -= dy;
            if (y < 0) {
              x = randomNum(distance.minWidth);
              y = randomRangeNum(distance.minHeight, distance.maxHeight);
            }
            break;
          case Direction.DOWN:
            y += dy;
            if (y > distance.maxHeight) {
              x = randomNum(distance.minWidth);
              y = -randomRangeNum(distance.minHeight, distance.maxHeight);
            }
            break;
          case Direction.LEFT:
            x -= dx;
            if (x < 0) {
              x = randomRangeNum(distance.minWidth, distance.maxWidth);
              y = randomNum(distance.minHeight);
            }
            break;
          case Direction.RIGHT:
            x += dx;
            if (x > distance.maxWidth) {
              x = -randomRangeNum(distance.minWidth, distance.maxWidth);
              y = randomNum(distance.minHeight);
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

class Pieces {
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

  MovablePieces(int count, [Distance distance]) {
    createMovablePieces(count, distance);
  }

  createMovablePieces(int count, [Distance distance]) {
    var id = 0;
    if (distance == null) {
      for (var i = 0; i < count; i++) {
        add(new MovablePiece(++id));
      }
    } else {
      for (var i = 0; i < count; i++) {
        add(new MovablePiece(++id, distance));
      }
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

