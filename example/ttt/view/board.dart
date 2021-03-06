part of icacoe;

class Board extends Object with Surface {
  static const String xxColor = 'blue';
  static const String ooColor = 'orange';
  
  bool isLineCompleted = false;

  Board(CanvasElement canvas, TttGrid grid) {
    this.canvas = canvas;
    this.grid = grid;
    var lastPlay = TttGrid.oo;
    for (CellPiece cp in grid.cellPieces) {
      cp.isTagged = true;
      cp.tag.size  = 32;
    }
    LabelElement winnerLabel = querySelector("#winner");
    canvas.onMouseDown.listen((MouseEvent e) {
      if (!isGameOver) {
        var column = (e.offset.x ~/ grid.cellWidth).toInt();
        var row = (e.offset.y ~/ grid.cellHeight).toInt();
        CellPiece cp = grid.cellPieces.cellPiece(column, row);
        if (cp.tag.text == '') {
          if (lastPlay == TttGrid.oo) {
            cp.tag.text = TttGrid.xx;
            lastPlay = TttGrid.xx;
            cp.tag.color.main = xxColor;
          }
          else {
            cp.tag.text = TttGrid.oo;
            lastPlay = TttGrid.oo;
            cp.tag.color.main = ooColor;
          }
          if (isLineCompleted) {
            isGameOver = true;
          } else {
            isLineCompleted = grid.lineCompleted();
            if (isLineCompleted) {
              winnerLabel.text = 'winner is ${cp.tag.text}';
            }
          }
        }
      }
    });
  }
}