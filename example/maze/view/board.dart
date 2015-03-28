part of maze_gen;

class Board extends Surface {
  Board(CanvasElement canvas, MazeGrid grid) : super(canvas, grid: grid) {
    for (var cp in grid.cellPieces) {
      if (cp.tag.number == 0) {
        cp.color.main = 'orange'; // path
      } 
    }
  }
}