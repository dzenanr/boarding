part of util;

enum Direction {UP, DOWN, LEFT, RIGHT}

class Position {
  num x;
  num y;

  Position([this.x = 0, this.y = 0]);

  Position.fromJsonMap(Map<String, num> jsonMap): this(jsonMap['x'], jsonMap['y']);

  Map<String, num> toJsonMap() {
    var jsonMap = new Map<String, num>();
    jsonMap['x'] = x;
    jsonMap['y'] = y;
    return jsonMap;
  }
}

class Line {
  Position p1, p2;
  num width;
  num length = 40;
  int count = 1;
  
  Line([this.width = 1]);
  
  Line.fromJsonMap(Map<String, Object> jsonMap) {
    var position1 = jsonMap['p1'];
    var position2 = jsonMap['p2'];
    if (position1 != null && position2 != null) {
      p1 = new Position.fromJsonMap(jsonMap['p1']);
      p2 = new Position.fromJsonMap(jsonMap['p2']);
    }
    width = jsonMap['width'];
    length = jsonMap['length'];
    count = jsonMap['count'];
  }

  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
    if (p1 != null && p2 != null) {
      jsonMap['p1'] = p1.toJsonMap();
      jsonMap['p2'] = p2.toJsonMap();
    }
    jsonMap['width'] = width;
    jsonMap['length'] = length;
    jsonMap['count'] = count;
    return jsonMap;
  }
  
  static Line random(Size space) {
    var line = new Line();
    line.p1 = space.randomPosition();
    line.p2 = space.randomPosition();
    line.width = randomRangeNum(1, 2.50001);
    line.length = randomRangeNum(8, 32);
    line.count = randomRangeInt(4, 12);
    return line;
  }
}

class Speed {
  static const num limit = 6;
  
  num dx;
  num dy;

  Speed([this.dx = 1, this.dy = 1]);

  Speed.fromJsonMap(Map<String, num> jsonMap): this(jsonMap['dx'], jsonMap['dy']);

  Map<String, num> toJsonMap() {
    var jsonMap = new Map<String, num>();
    jsonMap['dx'] = dx;
    jsonMap['dy'] = dy;
    return jsonMap;
  }
  
  increase() {
    dx++; 
    dy++;
  }
  
  double() {
    dx = 2 * dx;
    dy = 2 * dy;
  }
  
  decrease() {
    dx--; 
    dy--;
  }
  
  changeDirection() {
    dx = -dx; 
    dy = -dy;
  }
  
  bool isFaster(Speed s) => dx > s.dx && dy > s.dy;
  bool isTwiceFaster(Speed s) => dx == 2 * s.dx && dy == 2* s.dy;
  bool isMuchFaster(Speed s) => dx > 2 * s.dx && dy > 2* s.dy;
  
  static Speed random() => new Speed(randomRangeNum(1, limit), randomRangeNum(1, limit));
}

class Size {
  num width;
  num height;

  Size([this.width = 32, this.height = 16]);

  Size.fromJsonMap(Map<String, num> jsonMap) {
    width = jsonMap['width'];
    height = jsonMap['height'];
  }

  Map<String, num> toJsonMap() {
    var jsonMap = new Map<String, num>();
    jsonMap['width'] = width;
    jsonMap['height'] = height;
    return jsonMap;
  }
  
  increase() {
    width++; 
    height++;
  }
  
  double() {
    width = 2 * width;
    height = 2 * height;
  }
  
  decrease() {
    width--; 
    height--;
  }
  
  bool increaseWithin(Size max) {
    var isIncreased = true;
    increase();
    if (width > max.width) {
      width = max.width;
      isIncreased = false;
    }
    if (height > max.width) {
      height = max.width;
      isIncreased = false;
    }
    return isIncreased;
  }
  
  doubleWithin(Size max) {
    var isDoubled = true;
    double();
    if (width > max.width) {
      width = max.width;
      isDoubled = false;
    }
    if (height > max.width) {
      height = max.width;
      isDoubled = false;
    }
    return isDoubled;
  }
  
  bool decreaseWithin(Size min) {
    var isDecreased = true;
    decrease();
    if (width < min.width) {
      width = min.width;
      isDecreased = false;
    }
    if (height < min.height) {
      height = min.height;
      isDecreased = false;
    }
    return isDecreased;
  }

  bool isBigger(Size s) => width > s.width && height > s.height;
  bool isTwiceBigger(Size s) => width == 2 * s.width && height == 2 * s.height;
  bool isMuchBigger(Size s) => width > 2 * s.width && height > 2 * s.height;
  
  Position randomPosition() => new Position(randomNum(width), randomNum(height));

  static Size random(num maxWidth, num maxHeight) => 
      new Size(randomNum(maxWidth), randomNum(maxHeight));
}

class Box {
  var position;
  var size;
  
  Box(this.position, this.size);

  Box.fromJsonMap(Map<String, Map> jsonMap) {
    position = new Position.fromJsonMap(jsonMap['position']);
    size = new Size.fromJsonMap(jsonMap['size']);
  }

  Map<String, Map> toJsonMap() {
    var jsonMap = new Map<String, Map>();
    jsonMap['position'] = position.toJsonMap();
    jsonMap['size'] = size.toJsonMap();
    return jsonMap;
  }
  
  num get x => position.x;
  set x(num x) => position.x = x;
  num get y => position.y;
  set y(num y) => position.y = y;

  num get width => size.width;
  set width(num width) => size.width = width;
  num get height => size.height;
  set height(num height) => size.height = height;
  
  stayWithinSpace(Size space) {
    if (x < 0) {
      x = 0;
    }
    if (y < 0) {
      y = 0;
    }
    if (x > space.width - width) {
      x = space.width - width;
    }
    if (y > space.height - height) {
      y = space.height - height;
    }
  }
  
  Rectangle toRect() => new Rectangle(x, y, width, height); 
}

class MinMaxSize {
  Size minSize;
  Size maxSize;

  MinMaxSize() {
    minSize = new Size(12, 8);
    maxSize = new Size(120, 80);
  }

  MinMaxSize.from(Size dimension) {
    minSize = dimension;
    maxSize = dimension;
  }

  MinMaxSize.fromJsonMap(Map<String, Map> jsonMap) {
    minSize = new Size.fromJsonMap(jsonMap['minSize']);
    maxSize = new Size.fromJsonMap(jsonMap['maxSize']);
  }

  Map<String, Map> toJsonMap() {
    var jsonMap = new Map<String, Map>();
    jsonMap['minSize'] = minSize.toJsonMap();
    jsonMap['maxSize'] = maxSize.toJsonMap();
    return jsonMap;
  }
  
  bool isEqualWidth() => minSize.width == maxSize.width;
  bool isEqualHeight() => minSize.height == maxSize.height;

  Size randomSize() =>
      new Size(randomRangeNum(minSize.width, maxSize.width),
               randomRangeNum(minSize.height, maxSize.height));
  
  Position randomPosition() =>
      new Position(randomNum(minSize.width), randomNum(minSize.height));
}

class MinMaxSpace extends MinMaxSize {

  MinMaxSpace() {
    minSize = new Size(600, 400);
    maxSize = new Size(800, 600);
  }

  MinMaxSpace.from(Size dimension): super.from(dimension);

  MinMaxSpace.fromJsonMap(Map<String, Map> jsonMap): super.fromJsonMap(jsonMap);
}