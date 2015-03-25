part of icacoe;

class TttGrid extends SquareGrid {
  static const String x = 'X';
  static const String o = 'O';

  TttGrid(int size): super(size);

  CellPiece newCell(Grid grid, int row, int column) =>
      new CellPiece(this, row, column);

  bool lineCompleted() {
    var c;
    var t;
    var line = [];
    // columns
    for (var x = 0; x < length; x++) {
      line = [];
      for (var y = 0; y < length; y++) {
        c = cells.cell(x, y);
        t = c.tag.text;
        line.add(t);
      }
      if (_completed(line)) return true;
    }
    // rows
    for (var y = 0; y < length; y++) {
      line = [];
      for (var x = 0; x < length; x++) {
        c = cells.cell(x, y);
        t = c.tag.text;
        line.add(t);
      }
      if (_completed(line)) return true;
    }
    // diagonal: \
    line = [];
    for (var d = 0; d < length; d++) {
      c = cells.cell(d, d);
      t = c.tag.text;
      line.add(t);
    }
    if (_completed(line)) return true;
    // diagonal: /
    line = [];
    var y = length - 1;
    for (var x = 0; x < length; x++) {
      c = cells.cell(x, y);
      t = c.tag.text;
      line.add(t);
      y--;
    }
    if (_completed(line)) return true;
    return false;
  }

  bool _completed(List line) =>
      line.every((String text) => text == x) ||
      line.every((String text) => text == o);
}