part of pieces;

enum PieceShape {CIRCLE, LINE, RECT, ROUNDED_RECT, SELECTED_RECT, SQUARE, STAR,
  TAG, VEHICLE}

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

class Piece {
  static const PieceShape defaultShape = PieceShape.RECT;
  static const String defaultText = 'Dart';
  static const String defaultColor = '#000000'; // black

  int id;
  PieceShape shape = defaultShape;
  Box box = new Box(new Position(0, 0), new Size(24, 16));
  var minMaxSize = new MinMaxSize();
  var minMaxSpace = new MinMaxSpace();
  String text = defaultText;
  String color = defaultColor;
  String borderColor = defaultColor;
  bool isVisible = true;
  bool isSelected = false;

  Piece(this.id);

  num get x => box.position.x;
  set x(num x) => box.position.x = x;
  num get y => box.position.y;
  set y(num y) => box.position.y = y;

  num get width => box.size.width;
  set width(num width) => box.size.width = width;
  num get height => box.size.height;
  set height(num height) => box.size.height = height;

  fromJsonMap(Map<String, Object> jsonMap) {
    id  = jsonMap['id'];
    shape = PieceShape.values[jsonMap['index']];
    box = new Box.fromJsonMap(jsonMap['box']);
    minMaxSize = new MinMaxSize.fromJsonMap(jsonMap['minMaxSize']);
    minMaxSpace = new MinMaxSpace.fromJsonMap(jsonMap['minMaxSpace']);
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
    jsonMap['box'] = box.toJsonMap();
    jsonMap['minMaxSize'] = minMaxSize.toJsonMap();
    jsonMap['minMaxSpace'] = minMaxSpace.toJsonMap();
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
    var position = minMaxSpace.randomPosition();
    var size = minMaxSize.randomSize();
    box = new Box(position, size);
    //box = minMaxSpace.randomBox();
    text = randomElement(colorList());
    color = colorMap()[text];
  }

  bool contains(num xx, num yy) =>
      ((xx >= x && xx <= x + width) && (yy >= y && yy <= y + height));
}

class MovablePiece extends Piece {
  static const num speedLimit = 6;

  Size _distanceSize;
  num dx = 1;
  num dy = 1;
  bool isMoving = true;

  MovablePiece(int id): super(id) {
    _distanceSize = minMaxSpace.minSize;
  }

  num get speed => max(dx, dy);

  fromJsonMap(Map<String, Object> jsonMap) {
    super.fromJsonMap(jsonMap);
    _distanceSize = new Size.fromJsonMap(jsonMap['distanceSize']);
    dx = jsonMap['dx'];
    dy = jsonMap['dy'];
    isMoving = jsonMap['isMoving'];
  }

  Map<String, Object> toJsonMap() {
    var jsonMap = super.toJsonMap();
    jsonMap['distanceSize'] = _distanceSize.toJsonMap();
    jsonMap['dx'] = dx;
    jsonMap['dy'] = dy;
    jsonMap['isMoving'] = isMoving;
    return jsonMap;
  }

  Size get distanceSize => _distanceSize;
  set distanceSize(Size distanceSize) {
    _distanceSize = distanceSize;
    if (shape == PieceShape.CIRCLE) {
      if (x + width / 2 > distanceSize.width) {
        x = distanceSize.width - width / 2;
      }
      if (y + height / 2 > distanceSize.height) {
        y = distanceSize.height - height / 2;
      }
    } else {
      if (x + width > distanceSize.width) {
        x = distanceSize.width - width;
      }
      if (y + height > distanceSize.height) {
        y = distanceSize.height - height;
      }
    }
  }

  randomInit() {
    super.randomInit();
    Position position = distanceSize.randomPosition();
    x = position.x;
    y = position.y;
    distanceSize = minMaxSpace.randomSize();
    dx = randomNum(speedLimit);
    dy = randomNum(speedLimit);
  }

  move([Direction direction]) {
    if (isMoving) {
      if (direction == null) {
        x += dx;
        y += dy;
        if (shape == PieceShape.CIRCLE) {
          if (x + width / 2 > distanceSize.width ||
              x - width / 2 < 0) {
            dx = -dx;
          }
          if (y + height / 2 > distanceSize.height ||
              y - height / 2 < 0) {
            dy = -dy;
          }
        } else {
          if (x > distanceSize.width - width || x < 0) {
            dx = -dx;
          }
          if (y > distanceSize.height - height || y < 0) {
            dy = -dy;
          }
        }
      } else {
        switch(direction) {
          case Direction.UP:
            y -= dy;
            if (y < 0) {
              x = randomNum(minMaxSpace.minSize.width);
              y = randomRangeNum(minMaxSpace.minSize.height, minMaxSpace.maxSize.height);
            }
            break;
          case Direction.DOWN:
            y += dy;
            if (y > minMaxSpace.maxSize.height) {
              x = randomNum(minMaxSpace.minSize.width);
              y = -randomRangeNum(minMaxSpace.minSize.height, minMaxSpace.maxSize.height);
            }
            break;
          case Direction.LEFT:
            x -= dx;
            if (x < 0) {
              x = randomRangeNum(minMaxSpace.minSize.width, minMaxSpace.maxSize.width);
              y = randomNum(minMaxSpace.minSize.height);
            }
            break;
          case Direction.RIGHT:
            x += dx;
            if (x > minMaxSpace.maxSize.width) {
              x = -randomRangeNum(minMaxSpace.minSize.width, minMaxSpace.maxSize.width);
              y = randomNum(minMaxSpace.minSize.height);
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

