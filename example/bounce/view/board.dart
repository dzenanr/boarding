part of bounce;

class Board extends Surface {
  var movablePieces;

  Board(CanvasElement canvas): super(canvas) {
    movablePieces = new MovablePieces(32);
    movablePieces.randomInit();
    movablePieces.forEach((MovablePiece p) {
      p.shape = PieceShape.CIRCLE;
      p.space = new Size(width, height);
    });
  }

  draw() {
    clear();
    movablePieces.forEach((MovablePiece p) {
      p.move();
      drawPiece(p);
    });
  }
}
