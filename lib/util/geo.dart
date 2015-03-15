part of util;

class Position {
  num x;
  num y;

  Position(this.x, this.y);

  Position.fromJsonMap(Map<String, num> jsonMap): this(jsonMap['x'], jsonMap['y']);

  Map<String, num> toJsonMap() {
    var jsonMap = new Map<String, num>();
    jsonMap['x'] = x;
    jsonMap['y'] = y;
    return jsonMap;
  }
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

  Position randomPosition() => new Position(randomNum(width), randomNum(height));

  Size randomSize() => new Size(randomNum(width), randomNum(height));

  bool isBigger(Size s) {
    if (width > s.width && height > s.height) {
      return true;
    }
    return false;
  }

  bool isMuchBigger(Size s) {
    if (width > 2 * s.width && height > 2 * s.height) {
      return true;
    }
    return false;
  }
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

  Size randomSize() =>
      new Size(randomRangeNum(minSize.width, maxSize.width),
               randomRangeNum(minSize.height, maxSize.height));

  bool isEqualWidth() => minSize.width == maxSize.width;
  bool isEqualHeight() => minSize.height == maxSize.height;
}

class MinMaxSpace extends MinMaxSize {

  MinMaxSpace() {
    minSize = new Size(600, 400);
    maxSize = new Size(800, 600);
  }

  MinMaxSpace.from(Size dimension): super.from(dimension);

  MinMaxSpace.fromJsonMap(Map<String, Map> jsonMap): super.fromJsonMap(jsonMap);

  Position randomPosition() =>
      new Position(randomNum(minSize.width), randomNum(minSize.height));
}