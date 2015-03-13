part of bounce;

class Board extends Surface {
  var movablePieces;

  Board(CanvasElement canvas): super(canvas) {
    movablePieces = new MovablePieces(32,
        distance: new Distance.from(canvas.width, canvas.height));
    movablePieces.randomInit();
    movablePieces.forEach((MovablePiece p) => p.shape = PieceShape.CIRCLE);
  }

  draw() {
    clear();
    movablePieces.forEach((MovablePiece p) {
      p.move();
      drawPiece(p);
    });
  }
}
