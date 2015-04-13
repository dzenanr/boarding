part of attract;

class Board extends Object with Surface {
  List<Map<String, num>> stars;
  num count = 25, minDistance = 100;

  Board(CanvasElement canvas) {
    color.main = 'black';
    this.canvas = canvas;
    stars = prepareStars(canvas, count);
    movablePieces = new MovablePieces();
    movablePieces.create(count);
    movablePieces.randomInit();
    movablePieces.forEach((MovablePiece p) {
      p.shape = PieceShape.CIRCLE;
      p.width = 12;
      p.height = 12;
      p.color.main = 'white';
      p.dx = 1;
      p.dy = 1;
      p.space = new Area.from(width, height);
    });
  }

  draw() {
    clear();
    drawStars(canvas, stars);
    movablePieces.forEach((MovablePiece p1) {
      movablePieces.forEach((MovablePiece p2) {
        if (p1.id != p2.id) {
          if (distance(p1, p2) <= minDistance) {
            drawDistanceLine(canvas, p1, p2, minDistance);
            accelerate(p1, p2);
          }
        }
      });
      p1.move();
      drawPiece(p1);
    });
  }
}