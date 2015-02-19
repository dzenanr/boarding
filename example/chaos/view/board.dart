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
    movingPieces.forEach((mp) => new MovingRectangle(this, mp).draw());
  }
}

class MovingRectangle {
  Surface surface;
  MovingPiece mp;
  
  MovingRectangle(this.surface, this.mp);
  
  draw() {
    mp.move();
    new Rect(surface, mp.x, mp.y, mp.width, mp.height, inColor: mp.colorCode).draw();
  }
}