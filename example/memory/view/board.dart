part of memory;

class Board extends Surface {
  num cellSize;
  
  Memory memory;
  MemoryCell lastCellClicked;

  Board(CanvasElement canvas, Memory memory): this.memory = memory,
      super(canvas, grid: memory) {
    cellSize = canvas.width / memory.size; // in pixels
    querySelector('#canvas').onMouseDown.listen((MouseEvent e) {
      int row = (e.offset.y ~/ cellSize).toInt();
      int column = (e.offset.x ~/ cellSize).toInt();
      MemoryCell cell = memory.cells.cell(row, column);
      cell.isHidden = false;
      if (cell.twin == lastCellClicked) {
        lastCellClicked.isHidden = false;
        if (memory.recalled) { // game over
          new Timer(const Duration(milliseconds: 5000), () => memory.hide());
        }
      } else if (cell.twin.isHidden) {
        new Timer(const Duration(milliseconds: 800), () => cell.isHidden = true);
      }
      lastCellClicked = cell;
    });
    window.animationFrame.then(gameLoop);
  }

  gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }

  draw() {
    super.draw();
    if (memory.recalled) { // game over
      new Tag(this, cellSize * 2, cellSize * 2, 32, 'YOU WIN', color: 'red').draw();
    }
  }
}
