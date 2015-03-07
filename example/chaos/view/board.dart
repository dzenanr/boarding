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
  
  drawPiece(Piece p) {
    switch(p.shape) {
      case PieceShape.CIRCLE:
        new Circle(this, p.x, p.y, p.width / 2, color: p.colorCode).draw(); 
        break;
      case PieceShape.LINE:
        new Line(this, p.x, p.y, p.width, p.height, color: p.colorCode).draw(); 
        break;
      case PieceShape.RECTANGLE:
        new Rect(this, p.x, p.y, p.width, p.height, color: p.colorCode).draw(); 
        break;
      case PieceShape.SQUARE:
        new Square(this, p.x, p.y, p.width, color: p.colorCode).draw(); 
        break;
      case PieceShape.TAG:
        new Tag(this, p.x, p.y, p.width, p.text, color: p.colorCode).draw();
    }
  }
}
