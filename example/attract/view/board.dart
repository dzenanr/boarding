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
      p.distanceMinWidth = canvas.width;
      p.distanceMaxWidth = canvas.width;
      p.distanceMinHeight = canvas.height;
      p.distanceMaxHeight = canvas.height;
      if (p.x + p.width / 2 > p.distanceMinWidth) {
        p.x = p.distanceMinWidth - p.width / 2;
      }
      if (p.y + p.height / 2 > p.distanceMinHeight) {
        p.y = p.distanceMinHeight - p.height / 2;
      }
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