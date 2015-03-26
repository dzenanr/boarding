part of memory;

class Board extends Surface {
  Memory memory;
  MemoryCell lastCellClicked;

  Board(CanvasElement canvas, Memory memory): this.memory = memory,
      super(canvas, grid: memory) {
    querySelector('#canvas').onMouseDown.listen((MouseEvent e) {
      int column = (e.offset.x ~/ memory.cellWidth).toInt();
      int row = (e.offset.y ~/ memory.cellHeight).toInt();
      MemoryCell cell = memory.cellPieces.cellPiece(column, row);
      cell.isCovered = false;
      if (cell.twin == lastCellClicked) {
        lastCellClicked.isCovered = false;
        if (memory.recalled) { // game over
          new Timer(const Duration(milliseconds: 5000), () => memory.hide());
        }
      } else if (cell.twin.isCovered) {
        new Timer(const Duration(milliseconds: 800), () => cell.isCovered = true);
      }
      lastCellClicked = cell;
    });
  }

  draw() {
    super.draw();
    if (memory.recalled) { // game over
      drawTag(canvas, memory.cellWidth * 2, memory.cellHeight * 2, 'YOU WIN', size: 32, 
          color: 'red');
    }
  }
}
