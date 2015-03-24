part of icacoe;

class Board extends SquareSurface {
  static const String xColor = 'blue';
  static const String oColor = 'orange';

  bool play = true;

  Board(CanvasElement canvas, TttGrid grid) : super(canvas, grid: grid) {
    var cellLength = length / grid.size; // in pixels
    var lastPlay = TttGrid.o;
    for (CellPiece cell in grid.cells) {
      cell.isTagged = true;
      cell.tag.size  = 32;
    }
    LabelElement winnerLabel = querySelector("#winner");
    canvas.onMouseDown.listen((MouseEvent e) {
      if (play) {
        var row = (e.offset.y ~/ cellLength).toInt();
        var column = (e.offset.x ~/ cellLength).toInt();
        CellPiece cell = grid.cells.cell(row, column);
        if (cell.tag.text == '') {
          if (lastPlay == TttGrid.o) {
            cell.tag.text = TttGrid.x;
            lastPlay = TttGrid.x;
            cell.tag.color.main = xColor;
          }
          else {
            cell.tag.text = TttGrid.o;
            lastPlay = TttGrid.o;
            cell.tag.color.main = oColor;
          }
          if (grid.lineCompleted()) {
            winnerLabel.text = 'winner is ${cell.tag.text}';
            play = false;
          }
        }
      }
    });
  }
}