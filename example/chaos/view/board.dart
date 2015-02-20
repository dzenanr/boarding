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
          new Circle(this, x: mp.x, y: mp.y, width: mp.width, color: mp.colorCode).draw();
          break;
        case Form.LINE:
          new Line(this, x: mp.x, y: mp.y, width: mp.width, height: mp.height, color: mp.colorCode).draw();
          break;
        case Form.RECTANGLE:
          new Rect(this, x: mp.x, y: mp.y, width: mp.width, height: mp.height, color: mp.colorCode).draw();
          break;
        case Form.SQUARE:
          new Square(this, x: mp.x, y: mp.y, width: mp.width, color: mp.colorCode).draw();
          break;
        case Form.TAG:
          new Tag(this, x: mp.x, y: mp.y, width: mp.width, text: mp.text, color: mp.colorCode).draw();
      }
    });
  }
}

