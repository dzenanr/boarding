part of lanes;

class Board extends Object with Surface {
  YellowLines yellowLines;

  Board(CanvasElement canvas) {
    color.main = 'black';
    this.canvas = canvas;
    yellowLines = new YellowLines(9);
    yellowLines.forEach((var yellowLine) {
      yellowLine.space = area;
      yellowLine.x = yellowLine.space.width / 2 - yellowLine.width / 2;
    });
    yellowLines.calcY();
    yellowLines.forEach((var yellowLine) {
      drawPiece(yellowLine);
    });
  }

  void draw() {
    clear();
    yellowLines.moveDown();
    yellowLines.forEach((var yellowLine) {
      drawPiece(yellowLine);
    });
  }
}