part of chaos;

class Board extends Surface {
  var movingPieces = new MovingPieces(16);
  
  Board(Grid2By2 grid, CanvasElement canvas) : super(grid, canvas) {
    movingPieces.randomInit();
    canvas.onMouseDown.listen((MouseEvent e) {
      movingPieces.onOff();
    });
    window.animationFrame.then(gameLoop);
  }
  
  gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }
  
  draw() {
    clear();
    movingPieces.forEach((MovingPiece mp) {
      mp.move();
      switch(mp.form) {
        case Form.CIRCLE:
          new Circle(this, mp.x, mp.y, mp.width / 2, color: mp.colorCode).draw();
          break;
        case Form.LINE:
          new Line(this, mp.x, mp.y, mp.width, mp.height, color: mp.colorCode).draw();
          break;
        case Form.RECTANGLE:
          new Rect(this, mp.x, mp.y, mp.width, mp.height, color: mp.colorCode).draw();
          break;
        case Form.SQUARE:
          new Square(this, mp.x, mp.y, mp.width, color: mp.colorCode).draw();
          break;
        case Form.TAG:
          new Tag(this, mp.x, mp.y, mp.width, mp.text, color: mp.colorCode).draw();
      }
    });
  }
}

