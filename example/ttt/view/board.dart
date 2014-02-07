part of icacoe;

class Board extends Surface {
  static const String X_COLOR = 'blue';
  static const String O_COLOR = 'orange';

  Board(SquareGrid grid, CanvasElement canvas) : super(grid, canvas) {
    var size = canvas.width;           // in pixels
    var cellSize = size / grid.length; // in pixels
    var lastPlay = SquareGrid.O;

    for (Cell cell in grid.cells) cell.textSize  = 32;
    LabelElement winnerLabel = querySelector("#winner");

    canvas.onMouseDown.listen((MouseEvent e) {
      int row = (e.offset.y ~/ cellSize).toInt();
      int column = (e.offset.x ~/ cellSize).toInt();
      Cell cell = grid.cell(row, column);
      if (cell.text == null) {
        if (lastPlay == SquareGrid.O) {
          cell.text = SquareGrid.X;
          lastPlay = SquareGrid.X;
          cell.textColor  = X_COLOR;
        }
        else {
          cell.text = SquareGrid.O;
          lastPlay = SquareGrid.O;
          cell.textColor  = O_COLOR;
        }
        if (winner()) winnerLabel.text = 'winner is ${cell.text}';
      }
    });

    window.animationFrame.then(gameLoop);
  }

  bool winner() => (grid as SquareGrid).lineCompleted();

  gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }
}