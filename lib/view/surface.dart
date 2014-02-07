part of boarding;

class Surface {
  num width, height; // in pixels

  Grid grid;

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  Surface(this.grid, this.canvas) {
    context = canvas.getContext("2d");
    width = canvas.width;
    height = canvas.height;
  }

  clear() {
    new Rectangle(this, 0, 0, width, height).draw();
  }

  lines() {
    var wgap = width / grid.width;
    var hgap = height / grid.height;
    var x, y;
    for (var row = 1; row < grid.height; row++) {
      x = 0;
      y = hgap * row;
      new Line(this, x, y, x + width, y).draw();
    }
    for (var col = 1; col < grid.width; col++) {
      x = wgap * col;
      y = 0;
      new Line(this, x, y, x, y + height).draw();
    }
  }

  cells() {
    var wgap = width / grid.width;
    var hgap = height / grid.height;
    var cells = grid.cells;
    for (Cell cell in cells) {
      if (cell.text != null && cell.textSize != null) {
        var row = cell.row;
        var col = cell.column;
        var x = wgap * col + wgap / 2 - (wgap / 2 - cell.textSize) / 2;
        var y = hgap * row + hgap / 2 + (wgap / 2 - cell.textSize) / 2;
        new Text(this, cell.text, cell.textSize, cell.textColor, x, y).draw();
      }
    }
  }

  draw() {
    clear();
    lines();
    cells();
  }
}