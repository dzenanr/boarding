part of grids;

class Cell {
  int row, column;
  String color;
  String image;
  String text;
  int textSize; // in pixels
  String textColor;
  bool hidden = false;
  String hiddenColor;

  Grid grid;

  Cell(this.grid, this.row, this.column) {
    if (!(0 <= row  && row    < grid.rowCount &&
        0 <= column && column < grid.columnCount))
      throw new Exception(
        'cell out of grid(${grid.columnCount}, ${grid.rowCount}) '
        '- row: $row, column: $column');
  }

  bool get shown => !hidden;

  bool intersects(num row, num column) {
    if (0 <= row    && row    < grid.rowCount &&
        0 <= column && column < grid.columnCount) {
      if (this.row == row && this.column == column) {
        return true;
      }
    } else throw new Exception(
        'cell out of grid(${grid.columnCount}, ${grid.rowCount}) '
        '- row: $row, column: $column');
    return false;
  }
}

class Cells {
  List<Cell> _list;

  Cells() {
    _list = new List<Cell>();
  }

  void add(Cell cell) {
    _list.add(cell);
  }

  int get length => _list.length;
  Iterator get iterator => _list.iterator;

  bool any(bool f(Cell cell)) => _list.any(f);
  bool every(bool f(Cell cell)) => _list.every(f);
}
