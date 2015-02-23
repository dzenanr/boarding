part of drop;

class Board extends Surface {
  FallingPieces fallingPieces;
  
  Board(CanvasElement canvas) : super(canvas) {
    fallingPieces = new FallingPieces(8);
    fallingPieces.randomInit();
    canvas.onMouseDown.listen((MouseEvent e) {
      fallingPieces.forEach((FallingPiece fp) {      
        var x = e.offset.x;
        var y = e.offset.y;
        if (fp.contains(x, y)) {
          if (fp.isSelected) {
            fp.isVisible = false;
          } else {
            fp.isSelected = true;
          }
        }
      });
    });
    window.animationFrame.then(gameLoop);
  }
  
  gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }
  
  draw() {
    clear();
    fallingPieces.forEach((FallingPiece fp) {
      fp.move();
      if (fp.isVisible) {
        if (fp.isSelected) {
          var r = fp.width / 2;
          new Circle(this, fp.x + r, fp.y + r, r, color: 'black').draw();
        } else {
          new Square(this, fp.x, fp.y, fp.width, color: fp.colorCode).draw();
        }
      }
    });
  }
}
