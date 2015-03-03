part of d2048;

class Board extends SquareSurface {
  Board(CanvasElement canvas, TileGrid grid) : super(canvas, grid: grid) {  
    document.onKeyDown.listen((KeyboardEvent event) {
      switch(event.keyCode) {
        case KeyCode.UP: 
          grid.cells.move(Direction.UP);
          grid.cells.merge(Direction.UP); 
          break;
        case KeyCode.DOWN: 
          grid.cells.move(Direction.DOWN);
          grid.cells.merge(Direction.DOWN); 
          break;
        case KeyCode.LEFT: 
          grid.cells.move(Direction.LEFT);
          grid.cells.merge(Direction.LEFT); 
          break;
        case KeyCode.RIGHT: 
          grid.cells.move(Direction.RIGHT);
          grid.cells.merge(Direction.RIGHT); 
      }
      if (grid.randomCell() == null) {
        grid.cells.forEach((Cell c) => c.color = 'white'); // game over
      }
    });
    window.animationFrame.then(gameLoop);
  }

  gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }
}