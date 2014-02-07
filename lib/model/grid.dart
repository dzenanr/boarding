part of boarding;

class Grid {
  int width;  // in columns
  int height; // in rows

  Cells cells = new Cells();

  Grid(this.width, this.height) {
    var cell;
    for (var x = 0; x < width; x++) {
      for (var y = 0; y < height; y++) {
        cell = new Cell(this, x, y);
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