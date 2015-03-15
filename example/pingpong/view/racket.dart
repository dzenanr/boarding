part of pingpong;

class Racket {
  static const num leftArrow = 37;
  static const num rightArrow = 39;

  Board board;
  num x, y, w, h;
  bool rightDown = false, leftDown = false;

  Racket(this.board, this.x, this.y, this.w, this.h) {
    draw();
    // Set rightDown or leftDown if the right or left keys are down.
    document.onKeyDown.listen((KeyboardEvent event) {
      if (event.keyCode == rightArrow)     rightDown = true;
      else if (event.keyCode == leftArrow) leftDown  = true;
    });
    // Unset rightDown or leftDown when the right or left key is released.
    document.onKeyUp.listen((KeyboardEvent event) {
      if (event.keyCode == rightArrow)     rightDown = false;
      else if (event.keyCode == leftArrow) leftDown  = false;
    });
    // Change a position of the racket with the mouse left or right mouvement.
    document.onMouseMove.listen((MouseEvent event) {
      var minX = board.offset.left;
      var maxX = minX + board.width;
      if (event.page.x > minX && event.page.x < maxX) {
        x = max(event.page.x - minX - (w / 2), 0);
        x = min(board.width - w, x);
      }
    });
  }

  draw() {
    drawRect(board.canvas, x, y, w, h);
  }
}