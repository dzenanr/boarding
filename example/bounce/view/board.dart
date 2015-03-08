part of bounce;

class Board extends Surface {
  var movablePieces = new MovablePieces(32);
  
  Board(CanvasElement canvas) : super(canvas) {
    movablePieces.randomInit();
    movablePieces.forEach((MovablePiece mp) => mp.shape = PieceShape.CIRCLE);
    window.animationFrame.then(gameLoop); 
  }
  
  gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }
  
  draw() {
    clear();
    movablePieces.forEach((MovablePiece mp) {
      mp.move();
      drawPiece(mp);
    });
  }
}
