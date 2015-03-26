part of stars;

class Board extends Surface {
  Stars stars;
  bool isUp = true;
  
  Board(CanvasElement canvas): super(canvas) {
    stars = new Stars(16);
    stars.randomInit();
    stars.forEach((Star star) {
      star.shape = PieceShape.STAR;
      star.space = new Area(width, height);
    });
  }
  
  draw() {
    clear();
    stars.forEach((Star star) {
      if (isUp) {
        isUp = star.increase();    
      } else {
        isUp = !star.decrease();
      }
      star.move();
      drawPiece(star);
    });
  }
  
}
