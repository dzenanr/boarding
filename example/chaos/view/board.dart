part of chaos;

class Board extends Object with Surface {
  Board(CanvasElement canvas) {
    this.canvas = canvas;
    avoidCollisions = true;
    pieces = new Pieces();
    pieces.create(16);
    pieces.randomExtraInit();
    canvas.onMouseDown.listen((MouseEvent e) {
      pieces.onOff();
    });
  }
}
