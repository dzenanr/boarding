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
      drawRect(canvas, 0, 0, width, height,
               color: grid.color, borderColor: grid.color);
    } else {
      drawRect(canvas, 0, 0, width, height,
               color: color, borderColor: color);
    }
  }

  lines() {
    var wgap = width / grid.columnCount;
    var hgap = height / grid.rowCount;
    var x, y;
    for (var row = 1; row < grid.rowCount; row++) {
      x = 0;
      y = hgap * row;
      drawLine(canvas, x, y, x + width, y);
    }
    for (var col = 1; col < grid.columnCount; col++) {
      x = wgap * col;
      y = 0;
      drawLine(canvas, x, y, x, y + height);
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
        drawRect(canvas, x, y, wgap, hgap, color: colorMap()[cell.hiddenColor]);
        var cx = x + wgap / 2;
        var cy = y + hgap / 2;
        var r = 4;
        drawCircle(canvas, cx, cy, r);
      } else {
        if (cell.color != null) {
          var x = wgap * col;
          var y = hgap * row;
          drawRect(canvas, x, y, wgap, hgap, color: colorMap()[cell.color]);
        }
        if (cell.text != null && cell.textSize != null) {
          var x = wgap * col + wgap / 2 - (wgap / 2 - cell.textSize) / 2;
          var y = hgap * row + hgap / 2 + (wgap / 2 - cell.textSize) / 2;
          x = x + cell.textSize / 4;
          drawTag(canvas, x, y, cell.textSize, cell.text, color: cell.textColor);
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
        drawCircleWithinSquare(canvas, piece.x, piece.y, piece.width,
            lineWidth: piece.lineWidth,
            color: piece.color, borderColor: piece.borderColor);
        /*
        var r = piece.width / 2;
        drawCircle(canvas, piece.x + r, piece.y + r, r, lineWidth: piece.lineWidth,
            color: piece.color, borderColor: piece.borderColor);
         */
        break;
      case PieceShape.ELLIPSE:
        drawEllipseWithinRect(canvas, piece.x, piece.y, piece.width, piece.height,
            lineWidth: piece.lineWidth,
            color: piece.color, borderColor: piece.borderColor);
        break;
      case PieceShape.LINE:
        drawLine(canvas, piece.x, piece.y, piece.width, piece.height,
            lineWidth: piece.lineWidth,
            color: piece.color, borderColor: piece.borderColor);
        break;
      case PieceShape.RECT:
        drawRect(canvas, piece.x, piece.y, piece.width, piece.height,
            lineWidth: piece.lineWidth,
            color: piece.color, borderColor: piece.borderColor);
        break;
      case PieceShape.ROUNDED_RECT:
        drawRoundedRect(canvas, piece.x, piece.y, piece.width, piece.height,
            lineWidth: piece.lineWidth,
            color: piece.color, borderColor: piece.borderColor);
        break;
      case PieceShape.SELECTED_RECT:
        drawSelectedRect(canvas, piece.x, piece.y, piece.width, piece.height,
            lineWidth: piece.lineWidth,
            color: piece.color, borderColor: piece.borderColor);
        break;
      case PieceShape.SQUARE:
        drawSquare(canvas, piece.x, piece.y, piece.width,
            lineWidth: piece.lineWidth,
            color: piece.color, borderColor: piece.borderColor);
        break;
      case PieceShape.STAR:
        drawStarWithinSquare(canvas, piece.x, piece.y, piece.width,
            lineWidth: piece.lineWidth,
            color: piece.color, borderColor: piece.borderColor);
        /*
        var r = piece.width / 2;
        drawStar(canvas, piece.x + r, piece.y + r, r, lineWidth: piece.lineWidth,
            color: piece.color, borderColor: piece.borderColor);
         */
        break;
      case PieceShape.TAG:
        drawTag(canvas, piece.x, piece.y, piece.width, piece.text,
            color: piece.color);
        break;
      case PieceShape.TRIANGLE:
        drawTriangleWithinSquare(canvas, piece.x, piece.y, piece.width,
            lineWidth: piece.lineWidth,
            color: piece.color, borderColor: piece.borderColor);
        break;
      case PieceShape.VEHICLE:
        drawVehicle(canvas, piece.x, piece.y, piece.width, piece.height,
            lineWidth: piece.lineWidth,
            color: piece.color, borderColor: piece.borderColor);
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