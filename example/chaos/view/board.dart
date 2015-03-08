part of chaos;

class Board extends Surface {
  bool avoidCollisions;
  
  var movablePieces = new MovablePieces(16);
  
  Board(CanvasElement canvas, {this.avoidCollisions: false}) : super(canvas) {
    movablePieces.randomInit();
    canvas.onMouseDown.listen((MouseEvent e) {
      movablePieces.onOff();
    });
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
      if (avoidCollisions) {
        movablePieces.avoidCollisions(mp);
      }
      drawPiece(mp);
    });
  }
}
