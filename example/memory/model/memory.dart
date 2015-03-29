part of memory;

class MemoryCell extends CellPiece {
  MemoryCell twin;

  MemoryCell(Memory memory, Cell cell): super(memory, cell);
}

class Memory extends Grid {
  bool _recalled = false;

  Memory(Table table): super(table) {
    if (columnCount.isOdd || rowCount.isOdd) {
      var msg = 'Memory size must be an even integer: (${size.columnCount}, ${size.rowCount})';
      throw new Exception(msg);
    }
    for (MemoryCell mc in cellPieces) {
      mc.isCovered = true;
      mc.color.main = getNotUsedColor();
      _setFreeTwinRandomCell(mc);
    }
  }

  CellPiece newCellPiece(Grid grid, Cell cell) => new MemoryCell(this, cell);

  _setFreeTwinRandomCell(MemoryCell mc) {
    if (mc.twin == null) {
      var column;
      var row;
      while (cellPieces.any((c) => c.twin == null)) {
        column = randomInt(columnCount);
        row = randomInt(rowCount);
        MemoryCell tc = cellPieces.cellPiece(column, row);
        if (tc.twin == null && 
            (tc.cell.column != mc.cell.column || tc.cell.row != mc.cell.row)) {
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
      if (cellPieces.every((c) => !c.isCovered)) _recalled = true;
    }
    return _recalled;
  }

  hide() {
    for (final cell in cellPieces) cell.isCovered = true;
    _recalled = false;
  }
}