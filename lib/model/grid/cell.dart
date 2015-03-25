part of grid;

class CellPiece extends Piece {
  int row, column;
  num _number = 0;

  Grid grid;

  CellPiece(this.grid, this.row, this.column) {
    if (!grid.contains(row, column)) {
      throw new Exception(
        'cell out of grid(${grid.columnCount}, ${grid.rowCount}) '
        '- row: $row, column: $column');
    }
    shape = PieceShape.RECT;
  }
  
  fromJsonMap(Map<String, Object> jsonMap) {
    super.fromJsonMap(jsonMap);
    row = jsonMap['row'];
    column = jsonMap['column'];
    _number = jsonMap['number'];
  }

  Map<String, Object> toJsonMap() {
    var jsonMap = super.toJsonMap();
    jsonMap['row'] = row;
    jsonMap['column'] = column;
    jsonMap['number'] = _number;
    return jsonMap;
  }
  
  /**
   * Compares two cells based on numbers.
   * If the result is less than 0 then the first cell is less than the second cell,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first cell is greater than the second cell.
   */
  int compareTo(CellPiece c) {
    return number.compareTo(c.number);
  }

  num get number => _number;
  set number(num n) {
    _number = n;
    tag.text = _number.toString();
  }
  
  empty() => tag.text = '';
  
  bool get isEmpty => tag.text == '';
  
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
  List<CellPiece> _list;
  
  Grid grid;

  Cells(this.grid) {
    _list = new List<CellPiece>();
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
  
  List<CellPiece> toList() {
    return _list.toList();
  }
  
  List<Map<String, Object>> toJsonList() {
    var jsonList = new List<Map<String, Object>>();
    forEach((CellPiece c) => jsonList.add(c.toJsonMap()));
    return jsonList;
  }
  
  String toJsonString() => JSON.encode(toJsonList());

  int get length => _list.length;
  Iterator get iterator => _list.iterator;
  
  add(CellPiece c) => _list.add(c);
  empty() => forEach((CellPiece c) => c.empty());

  forEach(f(CellPiece c)) => _list.forEach(f);
  bool any(bool f(CellPiece c)) => _list.any(f);
  bool every(bool f(CellPiece c)) => _list.every(f);
  CellPiece maxCell() => _list.reduce((CellPiece c1, CellPiece c2) => c1.compareTo(c2) == -1 ? c2 : c1);
  
  select() => forEach((CellPiece c) => c.isSelected = true);
  deselect() => forEach((CellPiece c) => c.isSelected = false);
  
  CellPiece firstSelectedCell() {
    for (CellPiece c in this) {
      if (c.isSelected) {
        return c;
      }
    }
    return null;
  }
  
  CellPiece cell(int row, int column) {
    for (CellPiece c in this) {
      if (c.isIn(row, column)) return c;
    }
    return null;
  }
  
  CellPiece neighbor(CellPiece c, Direction direction) {
    CellPiece neighbor;
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
  
  CellPiece randomCell() => _list[randomInt(length)];
  CellPiece randomAvailableCell() {
    if (any((CellPiece c) => c.isEmpty)) {
      var rc = randomCell();
      if (rc.isEmpty) return rc;
      else return randomAvailableCell();
    }
    return null;
  }
  
  move(Direction direction) {
    var moved = false;
    for (CellPiece c in this) {
      if (!c.isEmpty) {
        CellPiece n = neighbor(c, direction);
        if (n != null && n.isEmpty) {
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
    for (CellPiece c in this) {
      if (!c.isEmpty) {
        CellPiece n = neighbor(c, direction);
        if (n != null && !n.isEmpty) {
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
