part of boarding;

class Surface {
  String color = 'white';
  num width, height; // in pixels
  Rectangle offset;
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  bool withLines;

  Grid grid;

  Surface(this.canvas, {this.withLines: true, this.grid}) {
    context = canvas.getContext('2d');
    width = canvas.width;
    height = canvas.height;
    offset = canvas.offset;
    window.animationFrame.then(gameLoop);
  }

  gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }

  clear() {
    if (grid != null) {
      new Rect(canvas, 0, 0, width, height,
          color: grid.color, borderColor: grid.color).draw();
    } else {
      new Rect(canvas, 0, 0, width, height,
          color: color, borderColor: color).draw();
    }
  }

  lines() {
    var wgap = width / grid.columnCount;
    var hgap = height / grid.rowCount;
    var x, y;
    for (var row = 1; row < grid.rowCount; row++) {
      x = 0;
      y = hgap * row;
      new Line(canvas, x, y, x + width, y).draw();
    }
    for (var col = 1; col < grid.columnCount; col++) {
      x = wgap * col;
      y = 0;
      new Line(canvas, x, y, x, y + height).draw();
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
        new Rect(canvas, x, y, wgap, hgap, color: colorMap()[cell.hiddenColor]).draw();
        var cx = x + wgap / 2;
        var cy = y + hgap / 2;
        var r = 4;
        new Circle(canvas, cx, cy, r).draw();
      } else {
        if (cell.color != null) {
          var x = wgap * col;
          var y = hgap * row;
          new Rect(canvas, x, y, wgap, hgap, color: colorMap()[cell.color]).draw();
        }
        if (cell.text != null && cell.textSize != null) {
          var x = wgap * col + wgap / 2 - (wgap / 2 - cell.textSize) / 2;
          var y = hgap * row + hgap / 2 + (wgap / 2 - cell.textSize) / 2;
          x = x + cell.textSize / 4;
          new Tag(canvas, x, y, cell.textSize, cell.text, color: cell.textColor).draw();
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

  drawPiece(Piece piece) {
    switch(piece.shape) {
      case PieceShape.CIRCLE:
        new Circle(canvas, piece.x, piece.y, piece.width / 2,
            color: piece.color, borderColor: piece.borderColor).draw();
        break;
      case PieceShape.LINE:
        new Line(canvas, piece.x, piece.y, piece.width, piece.height,
            color: piece.color, borderColor: piece.borderColor).draw();
        break;
      case PieceShape.RECT:
        new Rect(canvas, piece.x, piece.y, piece.width, piece.height,
            color: piece.color, borderColor: piece.borderColor).draw();
        break;
      case PieceShape.ROUNDED_RECT:
        new RoundedRect(canvas, piece.x, piece.y, piece.width, piece.height,
            color: piece.color, borderColor: piece.borderColor).draw();
        break;
      case PieceShape.SELECTED_RECT:
        new SelectedRect(canvas, piece.x, piece.y, piece.width, piece.height,
            color: piece.color, borderColor: piece.borderColor).draw();
        break;
      case PieceShape.SQUARE:
        new Square(canvas, piece.x, piece.y, piece.width,
            color: piece.color, borderColor: piece.borderColor).draw();
        break;
      case PieceShape.STAR:
        new Star(canvas, piece.x, piece.y, piece.width / 2,
            innerRadius: piece.width / 4,
            color: piece.color, borderColor: piece.borderColor).draw();
        break;
      case PieceShape.TAG:
        new Tag(canvas, piece.x, piece.y, piece.width, piece.text,
            color: piece.color, borderColor: piece.borderColor).draw();
        break;
      case PieceShape.VEHICLE:
        new Vehicle(canvas, piece.x, piece.y, piece.width, piece.height,
            color: piece.color, borderColor: piece.borderColor).draw();
        break;
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