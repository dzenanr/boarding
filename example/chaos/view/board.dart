part of chaos;

class Board extends Object with Surface {
  Board(CanvasElement canvas) {
    this.canvas = canvas;
    avoidCollisions = true;
    movablePieces = new MovablePieces();
    movablePieces.create(16);
    movablePieces.randomExtraInit();
    canvas.onMouseDown.listen((MouseEvent e) {
      movablePieces.onOff();
    });
  }
}
