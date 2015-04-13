part of util;

enum DirectDirection {LEFT, RIGHT, UP, DOWN}
enum DiagonalDirection {LEFT_UP, RIGHT_UP, LEFT_DOWN, RIGHT_DOWN}
enum Direction {LEFT, RIGHT, UP, DOWN, LEFT_UP, RIGHT_UP, LEFT_DOWN, RIGHT_DOWN}

DirectDirection randomDirectDirection() {
  var i = randomInt(DirectDirection.values.length);
  return DirectDirection.values[i];
}

DiagonalDirection randomDiagonalDirection() {
  var i = randomInt(DiagonalDirection.values.length);
  return DiagonalDirection.values[i];
}

Direction randomDirection() {
  var i = randomInt(Direction.values.length);
  return Direction.values[i];
}

class Position {
  num x = 0;
  num y = 0;

  Position();

  Position.from(this.x, this.y);

  Position.fromJson(Map<String, Object> jsonMap):
    this.from(jsonMap['x'], jsonMap['y']);

  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
    jsonMap['x'] = x;
    jsonMap['y'] = y;
    return jsonMap;
  }
}

class Line {
  Position p1, p2;
  num width = 1;
  num length = 40;
  int count = 1;

  Line();

  Line.from(this.p1, this.p2);

  Line.fromJson(Map<String, Object> jsonMap) {
    var position1 = jsonMap['p1'];
    var position2 = jsonMap['p2'];
    if (position1 != null && position2 != null) {
      p1 = new Position.fromJson(jsonMap['p1']);
      p2 = new Position.fromJson(jsonMap['p2']);
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

  static Line random(Area space) {
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

  num dx = 1;
  num dy = 1;

  Speed();

  Speed.from(this.dx, this.dy);

  Speed.fromJson(Map<String, Object> jsonMap):
    this.from(jsonMap['dx'], jsonMap['dy']);

  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
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

  static Speed random() =>
      new Speed.from(randomRangeNum(1, limit), randomRangeNum(1, limit));
}

class Area {
  num width = 64;
  num height = 32;

  Area();

  Area.from(this.width, this.height);

  Area.fromJson(Map<String, Object> jsonMap):
    this.from(jsonMap['width'], jsonMap['height']);

  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
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

  bool increaseWithin(Area max) {
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

  doubleWithin(Area max) {
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

  bool decreaseWithin(Area min) {
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

  bool isBigger(Area s) => width > s.width && height > s.height;
  bool isTwiceBigger(Area s) => width == 2 * s.width && height == 2 * s.height;
  bool isMuchBigger(Area s) => width > 2 * s.width && height > 2 * s.height;

  Position randomPosition() =>
      new Position.from(randomNum(width), randomNum(height));

  static Area random(num maxWidth, num maxHeight) =>
      new Area.from(randomNum(maxWidth), randomNum(maxHeight));
}

class Box {
  Position position;
  Area area;

  Box() {
    position = new Position();
    area = new Area();
  }

  Box.from(this.position, this.area);

  Box.fromJson(Map<String, Object> jsonMap) {
    fromJsonMap(jsonMap);
  }

  fromJsonMap(Map<String, Object> jsonMap) {
    position = new Position.fromJson(jsonMap['position']);
    area = new Area.fromJson(jsonMap['area']);
  }

  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
    jsonMap['position'] = position.toJsonMap();
    jsonMap['area'] = area.toJsonMap();
    return jsonMap;
  }

  num get x => position.x;
  set x(num x) => position.x = x;
  num get y => position.y;
  set y(num y) => position.y = y;

  num get width => area.width;
  set width(num width) => area.width = width;
  num get height => area.height;
  set height(num height) => area.height = height;

  stayWithinSpace(Area space) {
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

class Size {
  int columnCount = 12;
  int rowCount = 8;

  Size();

  Size.from(this.columnCount, this.rowCount);

  Size.fromJson(Map<String, Object> jsonMap):
    this.from(jsonMap['columnCount'], jsonMap['rowCount']);

  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
    jsonMap['columnCount'] = columnCount;
    jsonMap['rowCount'] = rowCount;
    return jsonMap;
  }
}

class Table extends Box {
  Size size;

  Table() {
    size = new Size();
  }

  Table.from(this.size, Area area): super.from(new Position(), area);

  Table.fromJson(Map<String, Object> jsonMap): super.fromJson(jsonMap) {
    size = new Size.fromJson(jsonMap['size']);
  }

  fromJsonMap(Map<String, Object> jsonMap) {
    size = new Size.fromJson(jsonMap['size']);
    super.fromJsonMap(jsonMap);
  }

  Map<String, Object> toJsonMap() {
    var jsonMap = super.toJsonMap();
    jsonMap['size'] = size.toJsonMap();
    return jsonMap;
  }

  num get columnCount => size.columnCount;
  num get rowCount => size.rowCount;

  num get cellWidth => area.width / size.columnCount;
  num get cellHeight => area.height / size.rowCount;

  bool contains(Cell cell) =>
    0 <= cell.column && cell.column < size.columnCount &&
    0 <= cell.row && cell.row < size.rowCount;

  int randomColumn() => randomInt(size.columnCount);
  int randomRow() => randomInt(size.rowCount);
  Cell randomCell() => new Cell.from(randomColumn(), randomRow());
}

class Cell {
  int column = 0;
  int row = 0;

  Cell();

  Cell.from(this.column, this.row);

  Cell.fromJson(Map<String, Object> jsonMap):
    this.from(jsonMap['column'], jsonMap['row']);

  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
    jsonMap['column'] = column;
    jsonMap['row'] = row;
    return jsonMap;
  }

  bool isInCell(Cell c) => column == c.column && row == c.row;
  bool isLeftOfCell(Cell c) => column == column - 1 && row == row;
  bool isRightOfCell(Cell c) => column == column + 1 && row == row;
  bool isUpOfCell(Cell c) => column == column && row == row - 1;
  bool isDownOfCell(Cell c) => column == column && row == row + 1;

  bool isIn(int c, int r) => column == c && row == r;
  bool isLeftOf(int c, int r) => column == c - 1 && row == r;
  bool isRightOf(int c, int r) => column == c + 1 && row == r;
  bool isUpOf(int c, int r) => column == c && row == r - 1;
  bool isDownOf(int c, int r) => column == c && row == r + 1;
}

class MinMaxArea {
  Area minArea;
  Area maxArea;

  MinMaxArea() {
    minArea = new Area.from(12, 8);
    maxArea = new Area.from(120, 80);
  }

  MinMaxArea.from(Area area) {
    minArea = area;
    maxArea = area;
  }

  MinMaxArea.fromJson(Map<String, Object> jsonMap) {
    minArea = new Area.fromJson(jsonMap['minArea']);
    maxArea = new Area.fromJson(jsonMap['maxArea']);
  }

  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
    jsonMap['minArea'] = minArea.toJsonMap();
    jsonMap['maxArea'] = maxArea.toJsonMap();
    return jsonMap;
  }

  bool isEqualWidth() => minArea.width == maxArea.width;
  bool isEqualHeight() => minArea.height == maxArea.height;

  Area randomSize() =>
      new Area.from(randomRangeNum(minArea.width, maxArea.width),
                    randomRangeNum(minArea.height, maxArea.height));

  Position randomPosition() =>
      new Position.from(randomNum(minArea.width), randomNum(minArea.height));
}

class MinMaxSpace extends MinMaxArea {

  MinMaxSpace() {
    minArea = new Area.from(600, 400);
    maxArea = new Area.from(800, 600);
  }

  MinMaxSpace.from(Area area): super.from(area);

  MinMaxSpace.fromJson(Map<String, Object> jsonMap): super.fromJson(jsonMap);
}