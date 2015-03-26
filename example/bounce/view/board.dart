part of bounce;

class Board extends Surface {
  Board(CanvasElement canvas): super(canvas, movablePieces: new MovablePieces(32)) {
    movablePieces.randomInit();
    movablePieces.forEach((MovablePiece p) {
      p.shape = PieceShape.CIRCLE;
      p.space = new Area(width, height);
    });
  }
}
