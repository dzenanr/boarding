part of icacoe;

class Board extends Surface {
  static const String xColor = 'blue';
  static const String oColor = 'orange';

  bool play = true;

  Board(CanvasElement canvas, SquareGrid grid) : super(canvas, grid: grid) {
    var cellSize = canvas.width / grid.length; // in pixels
    var lastPlay = SquareGrid.o;
    for (Cell cell in grid.cells) cell.textSize  = 32;
    LabelElement winnerLabel = querySelector("#winner");
    canvas.onMouseDown.listen((MouseEvent e) {
      if (play) {
        var row = (e.offset.y ~/ cellSize).toInt();
        var column = (e.offset.x ~/ cellSize).toInt();
        Cell cell = grid.cell(row, column);
        if (cell.text == null) {
          if (lastPlay == SquareGrid.o) {
            cell.text = SquareGrid.x;
            lastPlay = SquareGrid.x;
            cell.textColor  = xColor;
          }
          else {
            cell.text = SquareGrid.o;
            lastPlay = SquareGrid.o;
            cell.textColor  = oColor;
          }
          if (grid.lineCompleted()) {
            winnerLabel.text = 'winner is ${cell.text}';
            play = false;
          }
        }
      }
    });
    window.animationFrame.then(gameLoop);
  }

  gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }
}