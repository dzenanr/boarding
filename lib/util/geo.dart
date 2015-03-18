part of util;

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
  
  static Speed random() => new Speed(randomNum(limit), randomNum(limit));
}

class Size {
  num width;
  num height;

  Size(this.width, this.height);

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

  bool isBigger(Size s) => width > s.width && height > s.height;
  bool isTwiceBigger(Size s) => width == 2 * s.width && height == 2 * s.height;
  bool isMuchBigger(Size s) => width > 2 * s.width && height > 2 * s.height;
  
  Position randomPosition() => new Position(randomNum(width), randomNum(height));

  static Size random(num maxWidth, num maxHeight) => 
      new Size(randomNum(maxWidth), randomNum(maxHeight));
}

class Box {
  Position position;
  Size size;

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