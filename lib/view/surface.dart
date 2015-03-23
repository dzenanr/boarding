part of boarding;

class Surface {
  Size size; // in pixels
  Rectangle offset;
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  Color color = new Color('white');
  bool withLines;
  bool avoidCollisions;

  Grid grid;
  MovablePieces movablePieces;

  Surface(this.canvas, 
      {this.grid, this.withLines: false, this.movablePieces, this.avoidCollisions: false}) {
    context = canvas.getContext('2d');
    size = new Size(canvas.width, canvas.height);
    offset = canvas.offset;
    color.border = color.main;
    window.animationFrame.then(gameLoop);
  }
  
  num get width => size.width;
  num get height => size.height;

  gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }

  clear() {
    if (grid != null) {
      drawRect(canvas, 0, 0, width, height, 
          color: grid.color.main, borderColor: grid.color.border);
    } else {
      drawRect(canvas, 0, 0, width, height, 
          color: color.main, borderColor: color.border);
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
    for (CellPiece cell in cells) {
      var row = cell.row;
      var col = cell.column;
      if (cell.isCovered) {
        var x = wgap * col;
        var y = hgap * row;
        drawRect(canvas, x, y, wgap, hgap, 
                 lineWidth: cell.line.width, color: cell.color.cover, borderColor: cell.color.border);
        var cx = x + wgap / 2;
        var cy = y + hgap / 2;
        var r = 4;
        drawCircle(canvas, cx, cy, r);
      } else {
        if (cell.color.main != null) {
          var x = wgap * col;
          var y = hgap * row;
          drawRect(canvas, x, y, wgap, hgap, 
                   lineWidth: cell.line.width, color: cell.color.main, borderColor: cell.color.border);
        }
        if (cell.text.text != null) {
          var x = wgap * col + wgap / 2 - (wgap / 2 - cell.text.size) / 2;
          var y = hgap * row + hgap / 2 + (wgap / 2 - cell.text.size) / 2;
          x = x + cell.text.size / 4;
          drawTag(canvas, x, y, cell.text.text, size: cell.text.size, color: cell.text.color.main);
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
    if (movablePieces != null) {
      movablePieces.forEach((MovablePiece mp) {
        mp.move();
        if (avoidCollisions) {
          movablePieces.avoidCollisions(mp);
        }
        drawPiece(mp);
      });
    }
  }

  drawPiece(Piece piece) {
    switch(piece.shape) {
      case PieceShape.CIRCLE:
        drawCircleWithinSquare(canvas, piece.x, piece.y, piece.width,
            lineWidth: piece.line.width, color: piece.color.main, borderColor: piece.color.border);
        break;
      case PieceShape.ELLIPSE:
        drawEllipseWithinRect(canvas, piece.x, piece.y, piece.width, piece.height,
            lineWidth: piece.line.width, color: piece.color.main, borderColor: piece.color.border);
        break;
      case PieceShape.IMG:
        ImageElement img = document.querySelector('#${piece.imgId}');
        if (img != null) {
          drawImgWithinRect(canvas, piece.x, piece.y, piece.width, piece.height, img);
        }
        break;
      case PieceShape.LINE:
        drawLine(canvas, piece.line.p1.x, piece.line.p1.y, piece.line.p2.x, piece.line.p2.y,
            lineWidth: piece.line.width, color: piece.color.main); // no borderColor
        break;
      case PieceShape.POLYGON:
        var r = piece.width / 2;
        if (piece.line.length > r) {
          piece.line.length = r;
        }
        drawPolygonWithinSquare(canvas, piece.x, piece.y, piece.width, piece.line.length, piece.line.count,
            lineWidth: piece.line.width, color: piece.color.main, borderColor: piece.color.border);
        break;
      case PieceShape.RECT:
        drawRect(canvas, piece.x, piece.y, piece.width, piece.height,
            lineWidth: piece.line.width, color: piece.color.main, borderColor: piece.color.border);
        break;
      case PieceShape.ROUNDED_RECT:
        drawRoundedRect(canvas, piece.x, piece.y, piece.width, piece.height,
            lineWidth: piece.line.width, color: piece.color.main, borderColor: piece.color.border);
        break;
      case PieceShape.SELECTED_RECT:
        drawSelectedRect(canvas, piece.x, piece.y, piece.width, piece.height,
            lineWidth: piece.line.width, color: piece.color.main, borderColor: piece.color.border);
        break;
      case PieceShape.SQUARE:
        drawSquare(canvas, piece.x, piece.y, piece.width,
            lineWidth: piece.line.width, color: piece.color.main, borderColor: piece.color.border);
        break;
      case PieceShape.STAR:
        drawStarWithinSquare(canvas, piece.x, piece.y, piece.width,
            lineWidth: piece.line.width, color: piece.color.main, borderColor: piece.color.border);
        break;
      case PieceShape.TAG:
        drawTag(canvas, piece.x, piece.y, piece.text.text, font: piece.text.font, size: piece.text.size, 
            align: piece.text.align, maxWidth: piece.text.maxWidth, color: piece.text.color.main); 
        break;
      case PieceShape.TRIANGLE:
        drawTriangleWithinSquare(canvas, piece.x, piece.y, piece.width,
            lineWidth: piece.line.width, color: piece.color.main, borderColor: piece.color.border);
        break;
      case PieceShape.VEHICLE:
        drawVehicle(canvas, piece.x, piece.y, piece.width, piece.height,
            lineWidth: piece.line.width, color: piece.color.main, borderColor: piece.color.border);
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