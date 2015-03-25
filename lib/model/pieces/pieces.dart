part of pieces;

enum PieceShape {CIRCLE, ELLIPSE, IMG, LINE, POLYGON, RECT, ROUNDED_RECT, SELECTED_RECT, SQUARE, 
  STAR, TAG, TRIANGLE, VEHICLE}

accelerate(MovablePiece p1, MovablePiece p2, {num coefficient: 2000}) {
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

  int id;
  PieceShape shape = defaultShape;
  var minMaxSize = new MinMaxSize();
  var box;
  var minMaxSpace = new MinMaxSpace();
  var _space = new Size();
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

  Piece([this.id = 0]) {
    box = new Box(new Position(defaultX, defaultY), new Size(defaultWidth, defaultHeight));
  }
  
  Position get position => box.position;
  Size get size => box.size;

  num get x => box.x;
  set x(num x) => box.x = x;
  num get y => box.y;
  set y(num y) => box.y = y;

  num get width => box.width;
  set width(num width) => box.width = width;
  num get height => box.height;
  set height(num height) => box.height = height;

  Size get space => _space;
  set space(Size space) {
    _space = space;
    box.stayWithinSpace(space);
  }

  fromJsonMap(Map<String, Object> jsonMap) {
    id  = jsonMap['id'];
    shape = PieceShape.values[jsonMap['index']];
    minMaxSize = new MinMaxSize.fromJsonMap(jsonMap['minMaxSize']);
    box = new Box.fromJsonMap(jsonMap['box']);
    minMaxSpace = new MinMaxSpace.fromJsonMap(jsonMap['minMaxSpace']);
    _space = new Size.fromJsonMap(jsonMap['space']);
    line = new Line.fromJsonMap(jsonMap['line']);
    tag = new Tag.fromJsonMap(jsonMap['tag']);
    color = new Color.fromJsonMap(jsonMap['color']);
    imgId = jsonMap['imgId'];
    audioId = jsonMap['audioId'];
    usesAudio = jsonMap['usesAudio'];
    videoId = jsonMap['videoId'];
    usesVideo = jsonMap['usesVideo'];
    isVisible = jsonMap['isVisible'];
    isCovered = jsonMap['isCovered'];
    isSelected = jsonMap['isSelected'];
    isTagged = jsonMap['isTagged'];
  }

  fromJsonString(String jsonString) {
    Map<String, Object> jsonMap = JSON.decode(jsonString);
    fromJsonMap(jsonMap);
  }

  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
    jsonMap['id'] = id;
    jsonMap['index'] = shape.index;
    jsonMap['minMaxSize'] = minMaxSize.toJsonMap();
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
    return jsonMap;
  }

  String toJsonString() => JSON.encode(toJsonMap());

  randomInit() {
    var i = randomInt(PieceShape.values.length);
    shape = PieceShape.values[i];
    _space = minMaxSpace.randomSize();
    box.position = _space.randomPosition(); 
    box.size = minMaxSize.randomSize();
    line = Line.random(space);
    tag = Tag.random();
    color = Color.random();
  }
  
  randomExtraInit() {
    randomInit();
    isCovered = randomRareTrue();
    isTagged = randomRareTrue();
  }

  bool contains(num xx, num yy) =>
      ((xx >= x && xx <= x + width) && (yy >= y && yy <= y + height));
}

class MovablePiece extends Piece {
  var speed = new Speed();
  bool isMoving = true;

  MovablePiece([id = 0]): super(id);
  
  num get dx => speed.dx;
  set dx(num dx) => speed.dx = dx;
  num get dy => speed.dy;
  set dy(num dy) => speed.dy = dy;
  
  fromJsonMap(Map<String, Object> jsonMap) {
    super.fromJsonMap(jsonMap);
    speed = new Speed.fromJsonMap(jsonMap['speed']);
    isMoving = jsonMap['isMoving'];
  }

  Map<String, Object> toJsonMap() {
    var jsonMap = super.toJsonMap();
    jsonMap['speed'] = speed.toJsonMap();
    jsonMap['isMoving'] = isMoving;
    return jsonMap;
  }

  randomInit() {
    super.randomInit();
    speed = Speed.random();
  }
  
  randomExtraInit() {
    super.randomExtraInit();
    speed = Speed.random();
  }

  move([Direction direction]) {
    if (isMoving) {
      if (direction == null) {
        x += speed.dx;
        y += speed.dy;
        changeDirectionIfOutOfSpace();
      } else {
        switch(direction) {
          case Direction.UP:
            y -= speed.dy;
            if (y + height < 0) {
              x = randomNum(minMaxSpace.minSize.width);
              y = randomRangeNum(minMaxSpace.minSize.height, minMaxSpace.maxSize.height);
            }
            break;
          case Direction.DOWN:
            y += speed.dy;
            if (y > minMaxSpace.maxSize.height) {
              x = randomNum(minMaxSpace.minSize.width);
              y = -randomRangeNum(minMaxSpace.minSize.height, minMaxSpace.maxSize.height);
            }
            break;
          case Direction.LEFT:
            x -= speed.dx;
            if (x + width < 0) {
              x = randomRangeNum(minMaxSpace.minSize.width, minMaxSpace.maxSize.width);
              y = randomNum(minMaxSpace.minSize.height);
            }
            break;
          case Direction.RIGHT:
            x += speed.dx;
            if (x > minMaxSpace.maxSize.width) {
              x = -randomRangeNum(minMaxSpace.minSize.width, minMaxSpace.maxSize.width);
              y = randomNum(minMaxSpace.minSize.height);
            }
        }
      }
    }
  }

  onOff() => isMoving = !isMoving;
  
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
  
  randomInit() => forEach((p) => p.randomInit());
  randomExtraInit() => forEach((p) => p.randomExtraInit());

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

  onOff() => forEach((MovablePiece mp) => mp.onOff());

  avoidCollisions(MovablePiece mp) {
    for (var p in this) {
      if (p != mp) {
        mp.avoidCollision(p);
      }
    }
  }
}

