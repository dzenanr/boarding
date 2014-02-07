part of boarding;

class Cell {
  int row, column;
  String text;
  int textSize; // in pixels
  String textColor;

  Grid grid;

  Cell(this.grid, this.row, this.column);

  bool intersects(num row, num column) {
    if (0 <= row    && row    < grid.height &&
        0 <= column && column < grid.width) {
      if (this.row == row && this.column == column) {
        return true;
      }
      return false;
    } else throw new Exception(
        'cell out of grid - row: $row, column: $column');
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

  Iterator get iterator => _list.iterator;

  bool any(bool f(Cell cell)) => _list.any(f);
  bool every(bool f(Cell cell)) => _list.every(f);
}
