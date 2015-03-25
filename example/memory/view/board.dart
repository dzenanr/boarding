part of memory;

class Board extends Surface {
  num cellSize;

  Memory memory;
  MemoryCell lastCellClicked;

  Board(CanvasElement canvas, Memory memory): this.memory = memory,
      super(canvas, grid: memory) {
    cellSize = canvas.width / memory.length; // in pixels
    querySelector('#canvas').onMouseDown.listen((MouseEvent e) {
      int row = (e.offset.y ~/ cellSize).toInt();
      int column = (e.offset.x ~/ cellSize).toInt();
      MemoryCell cell = memory.cells.cell(row, column);
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
      drawTag(canvas, cellSize * 2, cellSize * 2, 'YOU WIN', size: 32, color: 'red');
    }
  }
}
