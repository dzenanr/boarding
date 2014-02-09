part of boarding;

class Grid {
  int width;  // in columns
  int height; // in rows

  Cells cells = new Cells();

  Grid(this.width, this.height) {
    var cell;
    for (var row = 0; row < height; row++) {
      for (var column = 0; column < width; column++) {
        cell = new Cell(this, row, column);
        cells.add(cell);
      }
    }
  }

  Cell cell(int row, int column) {
    if (0 <= row && row < height && 0 <= column && column < width) {
      for (Cell cell in cells) {
        if (cell.intersects(row, column)) {
          return cell;
        }
      }
    } else throw new Exception(
        'cell out of grid - row: $row, column: $column');
  }
}