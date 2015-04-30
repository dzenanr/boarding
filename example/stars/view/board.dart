part of stars;

class Board extends Object with Surface {
  Stars stars;
  bool isUp = true;

  Board(CanvasElement canvas) {
    this.canvas = canvas;
    stars = new Stars(16);
    stars.randomInit();
    stars.forEach((Star star) {
      star.shape = PieceShape.STAR;
      star.space = new Area.from(width, height);
    });
  }

  void draw() {
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
