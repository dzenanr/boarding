part of stars;

class Board extends Surface {
  Stars stars;
  bool isUp = true;
  
  Board(CanvasElement canvas): super(canvas) {
    stars = new Stars(16);
    stars.randomInit();
    stars.forEach((Star star) {
      star.shape = PieceShape.STAR;
      star.space = new Size(width, height);
    });
  }
  
  draw() {
    clear();
    stars.forEach((Star star) {
      if (isUp) {
        if (!star.increase()) {
          isUp = false;
        }
      } else {
        if (!star.decrease()) {
          isUp = true;
        }
      }
      star.move();
      drawPiece(star);
    });
  }
  
}
