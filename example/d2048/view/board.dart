part of d2048;

class Board extends SquareSurface {
  Board(CanvasElement canvas, GameGrid grid) : super(canvas, grid: grid) {  
    document.onKeyDown.listen((KeyboardEvent event) {
      if (event.keyCode == KeyCode.UP) {
        grid.cells.moveUpIfAvailable();
        grid.cells.mergeUpIfEqual();
      } else if (event.keyCode == KeyCode.DOWN) {
        grid.cells.moveDownIfAvailable();
        grid.cells.mergeDownIfEqual();
      } else if (event.keyCode == KeyCode.LEFT) {
        grid.cells.moveLeftIfAvailable();
        grid.cells.mergeLeftIfEqual();
      } else if (event.keyCode == KeyCode.RIGHT) {
        grid.cells.moveRightIfAvailable();
        grid.cells.mergeRightIfEqual();
      }
      var rc = grid.randomCell();
      if (rc == null) {
        // game over
        grid.cells.forEach((Cell c) => c.color = 'white');
      }
    });
    window.animationFrame.then(gameLoop);
  }

  gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }
}