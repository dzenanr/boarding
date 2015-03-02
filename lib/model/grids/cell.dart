part of grids;

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
  
  moveUp() {
    row = row - 1;
  }
  
  moveDown() {
    row = row + 1;
  }
  
  moveLeft() {
    column = column - 1;
  }
  
  moveRight() {
    column = column + 1;
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

  void add(Cell c) {
    _list.add(c);
  }

  int get length => _list.length;
  Iterator get iterator => _list.iterator;

  forEach(f(Cell c)) => _list.forEach(f);
  bool any(bool f(Cell c)) => _list.any(f);
  bool every(bool f(Cell c)) => _list.every(f);
  Cells where(bool f(Cell c)) => new Cells.fromList(_list.where(f).toList());
  
  select() {
    for (Cell c in this) {
      c.isSelected = true;
    }
  }
  
  deselect() {
    for (Cell c in this) {
      c.isSelected = false;
    }
  }
  
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
  
  Cell randomCell() {
    var i = randomInt(length);
    return _list[i];
  }
  
  Cell randomAvailableCell() {
    if (any((Cell c) => c.isAvailable)) {
      var rc = randomCell();
      if (rc.isAvailable) return rc;
      else return randomAvailableCell();
    }
    return null;
  }
  
  moveUpIfAvailable() {
    var moved = false;
    for (Cell c in this) {
      if (c.isUsed) {
        var n = cell(c.row - 1, c.column);
        if (n != null && n.isAvailable) {
          c.moveUp();
          n.moveDown();
          moved = true;
        }
      }
    }
    if (moved) moveUpIfAvailable();
  }
  
  moveDownIfAvailable() {
    var moved = false;
    for (Cell c in this) {
      if (c.isUsed) {
        var n = cell(c.row + 1, c.column);
        if (n != null && n.isAvailable) {
          c.moveDown();
          n.moveUp();
          moved = true;
        }
      }
    }
    if (moved) moveDownIfAvailable();
  }
  
  moveLeftIfAvailable() {
    var moved = false;
    for (Cell c in this) {
      if (c.isUsed) {
        var n = cell(c.row, c.column - 1);
        if (n != null && n.isAvailable) {
          c.moveLeft();
          n.moveRight();
          moved = true;
        }
      }
    }
    if (moved) moveLeftIfAvailable();
  }
  
  moveRightIfAvailable() {
    var moved = false;
    for (Cell c in this) {
      if (c.isUsed) {
        var n = cell(c.row, c.column + 1);
        if (n != null && n.isAvailable) {
          c.moveRight();
          n.moveLeft();
          moved = true;
        }
      }
    }
    if (moved) moveRightIfAvailable();
  }
  
  bool mergeUpIfEqual() {
    for (Cell c in this) {
      if (c.isUsed) {
        var n = cell(c.row - 1, c.column);
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
  
  bool mergeDownIfEqual() {
    for (Cell c in this) {
      if (c.isUsed) {
        var n = cell(c.row + 1, c.column);
        if (n != null && !n.isAvailable) {
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
  
  bool mergeLeftIfEqual() {
    for (Cell c in this) {
      if (c.isUsed) {
        var n = cell(c.row, c.column - 1);
        if (n != null && !n.isAvailable) {
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
  
 bool mergeRightIfEqual() {
    for (Cell c in this) {
      if (c.isUsed) {
        var n = cell(c.row, c.column + 1);
        if (n != null && !n.isAvailable) {
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
