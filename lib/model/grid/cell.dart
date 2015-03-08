part of grid;

enum Direction {UP, DOWN, LEFT, RIGHT}

class Cell {
  int row, column;
  String color;
  String image;
  String _text;
  int textSize = 16; // in pixels
  String textColor = 'black';
  num _number = 0;
  bool isHidden = false;
  String hiddenColor;
  bool isSelected = false;

  Grid grid;

  Cell(this.grid, this.row, this.column) {
    if (!grid.contains(row, column)) 
      throw new Exception(
        'cell out of grid(${grid.columnCount}, ${grid.rowCount}) '
        '- row: $row, column: $column');
  }
  
  fromJsonMap(Map<String, Object> jsonMap) {
    row = jsonMap['row'];
    column = jsonMap['column'];
    color = jsonMap['color'];
    image = jsonMap['image'];
    _text = jsonMap['text'];
    textSize = jsonMap['textSize'];
    textColor = jsonMap['textColor'];
    _number = jsonMap['number'];
    isHidden = jsonMap['isHidden'];
    hiddenColor = jsonMap['hiddenColor'];
    isSelected = jsonMap['isSelected'];
  }
  
  fromJsonString(String jsonString) {
    Map<String, Object> jsonMap = JSON.decode(jsonString);
    fromJsonMap(jsonMap);
  }
  
  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
    jsonMap['row'] = row;
    jsonMap['column'] = column;
    jsonMap['color'] = color;
    jsonMap['image'] = image;
    jsonMap['text'] = _text;
    jsonMap['textSize'] = textSize;
    jsonMap['textColor'] = textColor;
    jsonMap['number'] = _number;
    jsonMap['isHidden'] = isHidden;
    jsonMap['hiddenColor'] = hiddenColor;
    jsonMap['isSelected'] = isSelected;
    return jsonMap;
  }
  
  String toJsonString() => JSON.encode(toJsonMap());
  
  /**
   * Compares two cells based on numbers.
   * If the result is less than 0 then the first cell is less than the second cell,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first cell is greater than the second cell.
   */
  int compareTo(Cell c) {
    return number.compareTo(c.number);
  }
  
  String get text => _text;
  set text(String s) {
    _text = s;
    if (_text == '') {
      color = grid.defaultColor;
    }
  }

  num get number => _number;
  set number(num n) {
    _number = n;
    text = _number.toString();
  }
  
  empty() => text = '';
  
  bool get isEmpty => text == '';
  bool get isShown => !isHidden; 
  bool get isAvailable => text == null  || isEmpty;
  bool get isUsed => !isAvailable;
  
  bool isIn(int row, int column) => this.row == row && this.column == column;
  bool isUpOf(int row, int column) => this.row == row - 1 && this.column == column;
  bool isDownOf(int row, int column) => this.row == row + 1 && this.column == column;
  bool isLeftOf(int row, int column) => this.row == row && this.column == column - 1;
  bool isRightOf(int row, int column) => this.row == row && this.column == column + 1;
  
  move(Direction direction) {
    switch(direction) {
      case Direction.UP:
        row = row - 1; break;
      case Direction.DOWN:
        row = row + 1; break;
      case Direction.LEFT:
        column = column - 1; break;
      case Direction.RIGHT:
        column = column + 1;
    }
  }
}

class Cells {
  List<Cell> _list;
  
  Grid grid;

  Cells(this.grid) {
    _list = new List<Cell>();
  }
  
  fromJsonList(List<Map<String, Object>> jsonList) {
    jsonList.forEach((jsonMap) {
      var c = cell(jsonMap['row'], jsonMap['column']);
      if (c != null) {
        c.fromJsonMap(jsonMap);
      }
    });
  }
  
  fromJsonString(String jsonString) {
    List<Map<String, Object>> jsonList = JSON.decode(jsonString);
    fromJsonList(jsonList);
  }
  
  List<Cell> toList() {
    return _list.toList();
  }
  
  List<Map<String, Object>> toJsonList() {
    var jsonList = new List<Map<String, Object>>();
    forEach((Cell c) => jsonList.add(c.toJsonMap()));
    return jsonList;
  }
  
  String toJsonString() => JSON.encode(toJsonList());

  int get length => _list.length;
  Iterator get iterator => _list.iterator;
  
  add(Cell c) => _list.add(c);
  empty() => forEach((Cell c) => c.empty());

  forEach(f(Cell c)) => _list.forEach(f);
  bool any(bool f(Cell c)) => _list.any(f);
  bool every(bool f(Cell c)) => _list.every(f);
  Cell maxCell() => _list.reduce((Cell c1, Cell c2) => c1.compareTo(c2) == -1 ? c2 : c1);
  
  select() => forEach((Cell c) => c.isSelected = true);
  deselect() => forEach((Cell c) => c.isSelected = false);
  
  Cell firstSelectedCell() {
    for (Cell c in this) {
      if (c.isSelected) {
        return c;
      }
    }
    return null;
  }
  
  Cell cell(int row, int column) {
    for (Cell c in this) {
      if (c.isIn(row, column)) return c;
    }
    return null;
  }
  
  Cell neighbor(Cell c, Direction direction) {
    Cell neighbor;
    switch(direction) {
      case Direction.UP:
        neighbor = cell(c.row - 1, c.column); break;
      case Direction.DOWN:
        neighbor = cell(c.row + 1, c.column); break;
      case Direction.LEFT:
        neighbor = cell(c.row, c.column - 1); break;
      case Direction.RIGHT:
        neighbor = cell(c.row, c.column + 1);
    }  
    return neighbor;
  }
  
  Cell randomCell() => _list[randomInt(length)];
  Cell randomAvailableCell() {
    if (any((Cell c) => c.isAvailable)) {
      var rc = randomCell();
      if (rc.isAvailable) return rc;
      else return randomAvailableCell();
    }
    return null;
  }
  
  move(Direction direction) {
    var moved = false;
    for (Cell c in this) {
      if (c.isUsed) {
        Cell n = neighbor(c, direction);
        if (n != null && n.isAvailable) {
          c.move(direction);
          switch(direction) {
            case Direction.UP:
              n.move(Direction.DOWN); break;
            case Direction.DOWN:
              n.move(Direction.UP); break;
            case Direction.LEFT:
              n.move(Direction.RIGHT); break;
            case Direction.RIGHT:
              n.move(Direction.LEFT); 
          }
          moved = true;
        }     
      }
    }
    if (moved) move(direction);
  }
  
  bool merge(Direction direction) {
    for (Cell c in this) {
      if (c.isUsed) {
        Cell n = neighbor(c, direction);
        if (n != null && n.isUsed) {
          if (c.number == n.number) {
            n.number = n.number + n.number;
            c.empty();
            return true;
          }
        }
      }
    }
    return false;
  }
}
