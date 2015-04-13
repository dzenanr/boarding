part of p_art;

class Board extends Object with Surface {
  Board(CanvasElement canvas, ArtGrid grid) {
    this.canvas = canvas;
    this.grid = grid;
  }
}