part of memory;

class MemoryCell extends CellPiece {
  MemoryCell twin;

  MemoryCell(Memory memory, int row, int column): super(memory, row, column);
}

class Memory extends SquareGrid {
  bool _recalled = false;

  Memory(int size): super(size) {
    if (size.isOdd) {
      throw new Exception('Memory length must be an even integer: $size.');
    }
    for (MemoryCell mc in cells) {
      mc.isCovered = true;
      mc.color.main = getNotUsedColor();
      _setFreeTwinRandomCell(mc);
    }
  }

  CellPiece newCell(Grid grid, int row, int column) =>
      new MemoryCell(this, row, column);

  _setFreeTwinRandomCell(MemoryCell mc) {
    if (mc.twin == null) {
      var row;
      var column;
      while (cells.any((c) => c.twin == null)) {
        row = randomInt(size);
        column = randomInt(size);
        MemoryCell tc = cells.cell(row, column);
        if (tc.twin == null && (tc.row != mc.row || tc.column != mc.column)) {
          mc.twin = tc;
          tc.twin = mc;
          tc.color = mc.color;
          break;
        }
      }
    }
  }

  bool get recalled {
    if (!_recalled) {
      if (cells.every((c) => !c.isCovered)) _recalled = true;
    }
    return _recalled;
  }

  hide() {
    for (final cell in cells) cell.isCovered = true;
    _recalled = false;
  }
}