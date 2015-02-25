part of breakout;

class Racket {
  static const num height = 10;
  static const num width = 75;
  static const num leftArrow = 37;
  static const num rightArrow = 39;

  Board board;
  num x, y;
  bool rightDown = false, leftDown = false;
  String color, outline;

  Racket(this.board, this.color, [this.outline]) {
    x = board.width / 2;
    y = board.height - height;
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
        x = max(event.page.x - minX - (width / 2), 0);
        x = min(board.width - width, x);
      }
    });
  }

  draw() {
    new Rect(board, x, y, width, height, color: color, borderColor: outline).draw();
  }
}