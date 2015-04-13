part of bounce;

class Board extends Object with Surface {
  Board(CanvasElement canvas) {
    this.canvas = canvas;
    movablePieces = new MovablePieces();
    movablePieces.create(32);
    movablePieces.randomInit();
    movablePieces.forEach((MovablePiece p) {
      p.shape = PieceShape.CIRCLE;
      p.space = new Area.from(width, height);
    });
  }
}
