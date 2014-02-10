part of memory;

class Board extends Surface {
  num cellSize;
  MemoryCell lastCellClicked;

  Board(Memory memory, CanvasElement canvas) : super(memory, canvas) {
    cellSize = canvas.width / memory.length; // in pixels
    querySelector('#canvas').onMouseDown.listen((MouseEvent e) {
      int row = (e.offset.y ~/ cellSize).toInt();
      int column = (e.offset.x ~/ cellSize).toInt();
      MemoryCell cell = (grid as Memory).cell(row, column);
      cell.hidden = false;
      if (cell.twin == lastCellClicked) {
        lastCellClicked.hidden = false;
        if ((grid as Memory).recalled) { // game over
          new Timer(const Duration(milliseconds: 5000), () =>
              (grid as Memory).hide());
        }
      } else if (cell.twin.hidden) {
        new Timer(const Duration(milliseconds: 800), () => cell.hidden = true);
      }
      lastCellClicked = cell;
    });
    window.animationFrame.then(gameLoop);
  }

  void gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }

  void draw() {
    super.draw();
    if ((grid as Memory).recalled) { // game over
      context.font = 'bold 25px sans-serif';
      context.fillStyle = 'red';
      context.fillText('YOU WIN', cellSize, cellSize * 2);
    }
  }
}
