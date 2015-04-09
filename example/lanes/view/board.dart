part of lanes;

class Board extends Surface {
  YellowLines yellowLines;

  Board(CanvasElement canvas): super(canvas) {
    color.main = 'black';
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

  draw() {
    clear();
    yellowLines.moveDown();
    yellowLines.forEach((var yellowLine) {
      drawPiece(yellowLine);
    });
  }
}