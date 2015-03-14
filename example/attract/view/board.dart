part of attract;

class Board extends Surface {
  List<Map<String, num>> stars;
  MovablePieces ps;
  num count = 25, minDistance = 100;

  Board(CanvasElement canvas): super(canvas) {
    color = 'black';
    stars = prepareStars(canvas, count);
    ps = new MovablePieces(count);
    ps.randomInit();
    ps.forEach((MovablePiece p) {
      p.shape = PieceShape.CIRCLE;
      p.width = 12;
      p.height = 12;
      p.color = 'white';
      p.dx = 1;
      p.dy = 1;
      p.distanceSize = new Size(width, height);
    });
  }

  draw() {
    clear();
    drawStars(canvas, stars);
    ps.forEach((MovablePiece p1) {
      ps.forEach((MovablePiece p2) {
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