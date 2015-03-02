part of boarding;

class Surface {
  num width, height; // in pixels
  Rectangle offset;
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  bool withLines;
  
  Grid grid;

  Surface(this.canvas, {this.withLines: true, this.grid}) {
    context = canvas.getContext("2d");
    width = canvas.width;
    height = canvas.height;
    offset = canvas.offset;
  }

  clear() {
    if (grid != null) {
      new Rect(this, 0, 0, width, height, borderColor: grid.defaultColor).draw();
    } else {
      new Rect(this, 0, 0, width, height, borderColor: 'white').draw();
    } 
  }

  lines() {
    var wgap = width / grid.columnCount;
    var hgap = height / grid.rowCount;
    var x, y;
    for (var row = 1; row < grid.rowCount; row++) {
      x = 0;
      y = hgap * row;
      new Line(this, x, y, x + width, y).draw();
    }
    for (var col = 1; col < grid.columnCount; col++) {
      x = wgap * col;
      y = 0;
      new Line(this, x, y, x, y + height).draw();
    }
  }

  cells() {
    var wgap = width / grid.columnCount;
    var hgap = height / grid.rowCount;
    var cells = grid.cells;
    for (Cell cell in cells) {
      var row = cell.row;
      var col = cell.column;
      if (cell.isHidden) {
        var x = wgap * col;
        var y = hgap * row;
        new Rect(this, x, y, wgap, hgap, color: colorMap()[cell.hiddenColor]).draw();
        var cx = x + wgap / 2;
        var cy = y + hgap / 2;
        var r = 4;
        new Circle(this, cx, cy, r).draw();
      } else {
        if (cell.color != null) {
          var x = wgap * col;
          var y = hgap * row;
          new Rect(this, x, y, wgap, hgap, color: colorMap()[cell.color]).draw();
        }
        if (cell.text != null && cell.textSize != null) {
          var x = wgap * col + wgap / 2 - (wgap / 2 - cell.textSize) / 2;
          var y = hgap * row + hgap / 2 + (wgap / 2 - cell.textSize) / 2;
          x = x + cell.textSize / 4;
          new Tag(this, x, y, cell.textSize, cell.text, color: cell.textColor).draw();
        }
      }
    }
  }

  draw() {
    clear();
    if (grid != null) {
      if (withLines) lines();
      cells();
    }
  }
}

class SquareSurface extends Surface {
  int length; // in pixels
    
  SquareSurface(CanvasElement canvas, {bool withLines: true, SquareGrid grid}): 
    super(canvas, withLines: withLines, grid: grid) {
    length = width;
  }
}