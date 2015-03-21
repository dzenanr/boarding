part of chaos;

class Board extends Surface {
  Board(CanvasElement canvas) : super(canvas, movablePieces: new MovablePieces(16), 
      avoidCollisions: true) {
    movablePieces.randomInit();
    canvas.onMouseDown.listen((MouseEvent e) {
      movablePieces.onOff();
    });
  }
}
