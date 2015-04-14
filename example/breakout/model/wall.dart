part of breakout;

class Brick extends Object with Piece {
  Brick(int id, num width, num height) {
    shape = PieceShape.RECT;
    this.id = id;
    this.width = width;
    this.height = height;
  }
}

class Wall extends Object with Pieces {
  static const num brickDefaultHeight = 15;

  num rowCount, colCount;
  num width; // in pixels
  num brickCount;
  num brickWidth;
  num brickHeight = brickDefaultHeight;
  List bricks;

  Wall(this.rowCount, this.colCount, this.width) {
    brickCount = rowCount * colCount;
    brickWidth = (width / colCount) - 1;
    bricks = new List(rowCount);
    var id = 0;
    for (var i = 0; i < rowCount; i++) {
      bricks[i] = new List(colCount);
      for (var j = 0; j < colCount; j++) {
        var brick = new Brick(++id, brickWidth, brickHeight);
        brick.x = (j * (brick.width + 1)) + 1;
        brick.y = (i * (brick.height + 1)) + 1;
        brick.color.main = randomColor();
        brick.isVisible = true;
        bricks[i][j] = brick;
        add(brick);
      }
    }
  }

  // collision detection: http://www.metanetsoftware.com/
  bool contains(num x, num y) {
    var rowHeight = brickHeight;
    var colWidth = brickWidth;
    int row = (y / rowHeight).floor();
    int col = (x / colWidth).floor();
    if (row < rowCount && col < colCount &&
        row >= 0 && col >= 0 && y < rowCount * rowHeight) {
      // hit, mark the brick as broken (unvisible)
      Brick brick = bricks[row][col];
      if (brick.isVisible) {
        brick.isVisible = false;
        return true;
      }
    }
    return false;
  }
}