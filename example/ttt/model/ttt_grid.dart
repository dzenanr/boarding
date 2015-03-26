part of icacoe;

class TttGrid extends Grid {
  static const String xx = 'X';
  static const String oo = 'O';

  TttGrid(Table table): super(table);

  CellPiece newCellPiece(Grid grid, Cell cell) => new CellPiece(this, cell);

  bool lineCompleted() {
    var cp;
    var t;
    var line = [];
    // columns
    for (var x = 0; x < columnCount; x++) {
      line = [];
      for (var y = 0; y < rowCount; y++) {
        cp = cellPieces.cellPiece(x, y);
        t = cp.tag.text;
        line.add(t);
      }
      if (_completed(line)) return true;
    }
    // rows
    for (var y = 0; y < rowCount; y++) {
      line = [];
      for (var x = 0; x < columnCount; x++) {
        cp = cellPieces.cellPiece(x, y);
        t = cp.tag.text;
        line.add(t);
      }
      if (_completed(line)) return true;
    }
    // diagonal: \
    line = [];
    for (var d = 0; d < rowCount; d++) {
      cp = cellPieces.cellPiece(d, d);
      t = cp.tag.text;
      line.add(t);
    }
    if (_completed(line)) return true;
    // diagonal: /
    line = [];
    var y = rowCount - 1;
    for (var x = 0; x < columnCount; x++) {
      cp = cellPieces.cellPiece(x, y);
      t = cp.tag.text;
      line.add(t);
      y--;
    }
    if (_completed(line)) return true;
    return false;
  }

  bool _completed(List line) =>
      line.every((String text) => text == xx) ||
      line.every((String text) => text == oo);
}