part of icacoe;

class Board extends SquareSurface {
  static const String xColor = 'blue';
  static const String oColor = 'orange';

  bool play = true;

  Board(CanvasElement canvas, TttGrid grid) : super(canvas, grid: grid) {
    var cellLength = length / grid.size; // in pixels
    var lastPlay = TttGrid.o;
    for (Cell cell in grid.cells) cell.textSize  = 32;
    LabelElement winnerLabel = querySelector("#winner");
    canvas.onMouseDown.listen((MouseEvent e) {
      if (play) {
        var row = (e.offset.y ~/ cellLength).toInt();
        var column = (e.offset.x ~/ cellLength).toInt();
        Cell cell = grid.cells.cell(row, column);
        if (cell.text == null) {
          if (lastPlay == TttGrid.o) {
            cell.text = TttGrid.x;
            lastPlay = TttGrid.x;
            cell.textColor  = xColor;
          }
          else {
            cell.text = TttGrid.o;
            lastPlay = TttGrid.o;
            cell.textColor  = oColor;
          }
          if (grid.lineCompleted()) {
            winnerLabel.text = 'winner is ${cell.text}';
            play = false;
          }
        }
      }
    });
  }
}