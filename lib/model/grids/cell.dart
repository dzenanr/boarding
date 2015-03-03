part of grids;

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
  
  bool get isShown => !isHidden; 
  bool get isAvailable => text == null  || text.trim() == '';
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

  Cells() {
    _list = new List<Cell>();
  }
  
  Cells.fromList(List<Cell> cellList) {
    _list = new List<Cell>();
    cellList.forEach((Cell c) => _list.add(c));
  }

  int get length => _list.length;
  Iterator get iterator => _list.iterator;
  
  add(Cell c) => _list.add(c);
  bool remove(Cell c) => _list.remove(c);

  forEach(f(Cell c)) => _list.forEach(f);
  bool any(bool f(Cell c)) => _list.any(f);
  bool every(bool f(Cell c)) => _list.every(f);
  Cells where(bool f(Cell c)) => new Cells.fromList(_list.where(f).toList());
  
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
            c.text = '';
            return true;
          }
        }
      }
    }
    return false;
  }
}
