part of chaos;

class Board extends Surface {
  var movablePieces = new MovablePieces(16);
  bool avoidCollisions;
  
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
      switch(mp.shape) {
        case PieceShape.CIRCLE:
          new Circle(this, mp.x, mp.y, mp.width / 2, color: mp.colorCode).draw();
          break;
        case PieceShape.LINE:
          new Line(this, mp.x, mp.y, mp.width, mp.height, color: mp.colorCode).draw();
          break;
        case PieceShape.RECTANGLE:
          new Rect(this, mp.x, mp.y, mp.width, mp.height, color: mp.colorCode).draw();
          break;
        case PieceShape.SQUARE:
          new Square(this, mp.x, mp.y, mp.width, color: mp.colorCode).draw();
          break;
        case PieceShape.TAG:
          new Tag(this, mp.x, mp.y, mp.width, mp.text, color: mp.colorCode).draw();
      }
    });
  }
}

