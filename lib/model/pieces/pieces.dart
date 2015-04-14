part of pieces;

enum PieceShape {CIRCLE, ELLIPSE, FACE, IMG, LINE, POLYGON, RECT, ROUNDED_RECT,
  SELECTED_RECT, SQUARE, STAR, TAG, TRIANGLE, VEHICLE}

accelerate(Piece p1, Piece p2, {num coefficient: 2000}) {
  // Some acceleration depending upon distance.
  var xd = p1.x - p2.x, yd = p1.y - p2.y;
  var ax = xd / coefficient, ay = yd / coefficient;
  // Apply the acceleration.
  p1.dx -= ax; p1.dy -= ay;
  p2.dx += ax; p2.dy += ay;
}

num distance(Piece p1, Piece p2) { // in pixels
  var xd = p1.x - p2.x, yd = p1.y - p2.y;
  return sqrt(xd * xd + yd * yd);
}

class Piece {
  static const PieceShape defaultShape = PieceShape.RECT;
  static const defaultX = 0;
  static const defaultY = 0;
  static const defaultWidth = 32;
  static const defaultHeight = 32;

  int id = 0;
  PieceShape shape = defaultShape;
  var minMaxArea = new MinMaxArea();
  var box = new Box();
  var minMaxSpace = new MinMaxSpace();
  var _space = new Area();
  var line = new Line();
  var tag = new Tag();
  var color = new Color();
  String imgId;
  String audioId;
  bool usesAudio = false;
  String videoId;
  bool usesVideo = false;
  bool isVisible = true;
  bool isCovered = false;
  bool isSelected = false;
  bool isTagged = false;
  // movable part
  bool isMovable = true;
  var speed = new Speed();

  Position get position => box.position;
  Area get size => box.area;

  num get x => box.x;
  set x(num x) => box.x = x;
  num get y => box.y;
  set y(num y) => box.y = y;

  num get width => box.width;
  set width(num width) => box.width = width;
  num get height => box.height;
  set height(num height) => box.height = height;

  Area get space => _space;
  set space(Area space) {
    _space = space;
    box.stayWithinSpace(space);
  }

  // movable part
  num get dx => speed.dx;
  set dx(num dx) => speed.dx = dx;
  num get dy => speed.dy;
  set dy(num dy) => speed.dy = dy;

  fromJsonMap(Map<String, Object> jsonMap) {
    id  = jsonMap['id'];
    shape = PieceShape.values[jsonMap['index']];
    minMaxArea = new MinMaxArea.fromJson(jsonMap['minMaxArea']);
    box = new Box.fromJson(jsonMap['box']);
    minMaxSpace = new MinMaxSpace.fromJson(jsonMap['minMaxSpace']);
    _space = new Area.fromJson(jsonMap['space']);
    line = new Line.fromJson(jsonMap['line']);
    tag = new Tag.fromJson(jsonMap['tag']);
    color = new Color.fromJson(jsonMap['color']);
    imgId = jsonMap['imgId'];
    audioId = jsonMap['audioId'];
    usesAudio = jsonMap['usesAudio'];
    videoId = jsonMap['videoId'];
    usesVideo = jsonMap['usesVideo'];
    isVisible = jsonMap['isVisible'];
    isCovered = jsonMap['isCovered'];
    isSelected = jsonMap['isSelected'];
    isTagged = jsonMap['isTagged'];
    // movable part
    isMovable = jsonMap['isMovable'];
    speed = new Speed.fromJson(jsonMap['speed']);
  }

  fromJsonString(String jsonString) {
    Map<String, Object> jsonMap = JSON.decode(jsonString);
    fromJsonMap(jsonMap);
  }

  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
    jsonMap['id'] = id;
    jsonMap['index'] = shape.index;
    jsonMap['minMaxArea'] = minMaxArea.toJsonMap();
    jsonMap['box'] = box.toJsonMap();
    jsonMap['minMaxSpace'] = minMaxSpace.toJsonMap();
    jsonMap['space'] = _space.toJsonMap();
    jsonMap['line'] = line.toJsonMap();
    jsonMap['tag'] = tag.toJsonMap();
    jsonMap['color'] = color.toJsonMap();
    jsonMap['imgId'] = imgId;
    jsonMap['audioId'] = audioId;
    jsonMap['usesAudio'] = usesAudio;
    jsonMap['videoId'] = videoId;
    jsonMap['usesVideo'] = usesVideo;
    jsonMap['isVisible'] = isVisible;
    jsonMap['isCovered'] = isCovered;
    jsonMap['isSelected'] = isSelected;
    jsonMap['isTagged'] = isTagged;
    // movable part
    jsonMap['isMovable'] = isMovable;
    jsonMap['speed'] = speed.toJsonMap();
    return jsonMap;
  }

  String toJsonString() => JSON.encode(toJsonMap());

  randomInit() {
    var i = randomInt(PieceShape.values.length);
    shape = PieceShape.values[i];
    _space = minMaxSpace.randomSize();
    box.position = _space.randomPosition();
    box.area = minMaxArea.randomSize();
    line = Line.random(space);
    tag = Tag.random();
    color = Color.random();
    // movable part
    speed = Speed.random();
  }

  randomExtraInit() {
    randomInit();
    isCovered = randomRareTrue();
    isTagged = randomRareTrue();
    // movable part
    speed = Speed.random();
  }

  /**
   * Compares two pieces based on tags.
   * If the result is less than 0 then the first piece is less than the second piece,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first piece is greater than the second piece.
   */
  int compareTo(Piece p) {
    return tag.compareTo(p.tag);
  }

  bool contains(num xx, num yy) =>
      ((xx >= x && xx <= x + width) && (yy >= y && yy <= y + height));

  // movable part

  move([Direction direction]) {
    if (isMovable) {
      if (direction == null) {
        x += speed.dx;
        y += speed.dy;
        changeDirectionIfOutOfSpace();
      } else {
        switch(direction) {
          case Direction.LEFT:
            x -= speed.dx;
            if (x + width < 0) {
              x = randomRangeNum(minMaxSpace.minArea.width,
                  minMaxSpace.maxArea.width);
              y = randomNum(minMaxSpace.minArea.height);
            }
            break;
          case Direction.RIGHT:
            x += speed.dx;
            if (x > minMaxSpace.maxArea.width) {
              x = -randomRangeNum(minMaxSpace.minArea.width,
                  minMaxSpace.maxArea.width);
              y = randomNum(minMaxSpace.minArea.height);
            }
            break;
          case Direction.UP:
            y -= speed.dy;
            if (y + height < 0) {
              x = randomNum(minMaxSpace.minArea.width);
              y = randomRangeNum(minMaxSpace.minArea.height,
                  minMaxSpace.maxArea.height);
            }
            break;
          case Direction.DOWN:
            y += speed.dy;
            if (y > minMaxSpace.maxArea.height) {
              x = randomNum(minMaxSpace.minArea.width);
              y = -randomRangeNum(minMaxSpace.minArea.height,
                  minMaxSpace.maxArea.height);
            }
            break;
          case Direction.LEFT_UP:
            x -= speed.dx;
            y -= speed.dy;
            if (x + width < 0) {
              x = randomRangeNum(minMaxSpace.minArea.width,
                  minMaxSpace.maxArea.width);
              y = randomNum(minMaxSpace.minArea.height);
            }
            if (y + height < 0) {
              x = randomNum(minMaxSpace.minArea.width);
              y = randomRangeNum(minMaxSpace.minArea.height,
                  minMaxSpace.maxArea.height);
            }
            break;
          case Direction.RIGHT_UP:
            x += speed.dx;
            y -= speed.dy;
            if (x > minMaxSpace.maxArea.width) {
              x = -randomRangeNum(minMaxSpace.minArea.width,
                  minMaxSpace.maxArea.width);
              y = randomNum(minMaxSpace.minArea.height);
            }
            if (y + height < 0) {
              x = randomNum(minMaxSpace.minArea.width);
              y = randomRangeNum(minMaxSpace.minArea.height,
                  minMaxSpace.maxArea.height);
            }
            break;
          case Direction.LEFT_DOWN:
            x -= speed.dx;
            y += speed.dy;
            if (x + width < 0) {
              x = randomRangeNum(minMaxSpace.minArea.width,
                  minMaxSpace.maxArea.width);
              y = randomNum(minMaxSpace.minArea.height);
            }
            if (y > minMaxSpace.maxArea.height) {
              x = randomNum(minMaxSpace.minArea.width);
              y = -randomRangeNum(minMaxSpace.minArea.height,
                  minMaxSpace.maxArea.height);
            }
            break;
          case Direction.RIGHT_DOWN:
            x += speed.dx;
            y += speed.dy;
            if (x > minMaxSpace.maxArea.width) {
              x = -randomRangeNum(minMaxSpace.minArea.width,
                  minMaxSpace.maxArea.width);
              y = randomNum(minMaxSpace.minArea.height);
            }
            if (y > minMaxSpace.maxArea.height) {
              x = randomNum(minMaxSpace.minArea.width);
              y = -randomRangeNum(minMaxSpace.minArea.height,
                  minMaxSpace.maxArea.height);
            }
        }
      }
    }
  }

  onOff() => isMovable = !isMovable;

  jump() {
    box.position = space.randomPosition();
  }

  changeDirectionIfOutOfSpace() {
    if (x > space.width - width || x < 0) {
      speed.dx = -speed.dx;
    }
    if (y > space.height - height || y < 0) {
      speed.dy = -speed.dy;
    }
  }

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
        speed.changeDirection();
      }
    } else if (p.x > x  && p.y < y) {
      if (p.x <= x + width && p.y + p.height >= y) {
        speed.changeDirection();
      }
    } else if (p.x < x  && p.y > y) {
      if (p.x + p.width >= x && p.y <= y + height) {
        speed.changeDirection();
      }
    } else if (p.x > x  && p.y > y) {
      if (p.x <= x + width && p.y <= y + height) {
        speed.changeDirection();
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
  Piece firstWhere(bool f(Piece p)) => _pieceList.firstWhere(f);

  randomInit() => forEach((p) => p.randomInit());
  randomExtraInit() => forEach((p) => p.randomExtraInit());

  create(int count) {
    for (var i = 0; i < count; i++) {
      var p = new Piece();
      p.id = i;
      add(p);
    }
  }

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

  // movable part

  onOff() => forEach((Piece p) => p.onOff());

  avoidCollisions(Piece piece) {
    for (var p in this) {
      if (p != piece) {
        piece.avoidCollision(p);
      }
    }
  }
}



