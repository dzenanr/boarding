part of bounce;

class Board extends Object with Surface {
  Board(CanvasElement canvas) {
    this.canvas = canvas;
    pieces = new Pieces();
    pieces.create(32);
    pieces.randomInit();
    pieces.forEach((Piece p) {
      p.shape = PieceShape.CIRCLE;
      p.space = new Area.from(width, height);
    });
  }
}
