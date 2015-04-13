part of maze;

class Board extends Object with Surface {
  Board(CanvasElement canvas, MazeGrid grid) {
    this.canvas = canvas;
    this.grid = grid;
    for (var cp in grid.cellPieces) {
      if (cp.tag.isMarked) {
        cp.color.main = MazeCell.pathColor;
      }
    }
  }
}