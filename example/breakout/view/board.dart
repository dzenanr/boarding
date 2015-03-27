part of breakout;

class Board extends Surface {
  Bricks bricks;
  var ball = new Ball();
  var racket = new Racket();
  bool isGameOver;
  
  SelectElement selectSpeed;

  Board(CanvasElement canvas): super(canvas) {
    clear();
    querySelector('#play').onClick.listen((e) {
      init();
    });
    selectSpeed = querySelector('#speed');
    selectSpeed.value = '1';
    selectSpeed.onChange.listen((Event e) {
      _setBallSpeed();
    });
    document.onMouseMove.listen((MouseEvent event) {
      var minX = canvas.offset.left;
      var maxX = minX + width;
      if (event.page.x > minX && event.page.x < maxX) {
        var x = max(event.page.x - minX - (racket.width / 2), 0);
        racket.x = min(width - racket.width, x);
      }
    });
    init();
  }
  
  _setBallSpeed() {
    switch (selectSpeed.value) {
      case '1': ball.speed = new Speed(2, 4); break;
      case '2': ball.speed = new Speed(3, 6); break;
      case '3': ball.speed = new Speed(4, 8);
    }
  }

  init() {
    isGameOver = false;
    bricks = new Bricks(this);
    ball.x = width / 4;
    ball.y = height / 4;
    _setBallSpeed();
    ball.space = new Area(width, height);
    racket.y = height - racket.height;
  }

  clear() {
    drawRect(canvas, 0, 0, width, height, color: 'black');
  }

  draw() {
    if (!isGameOver) {
      clear();
      drawPiece(ball);
      drawPiece(racket);
      if (!bricks.draw()) return false; // user wins
      // If hit, reverse the ball.
      if (bricks.wall.contains(ball.x, ball.y)) ball.dy = -ball.dy;
      if ((ball.y + ball.dy + ball.height > height - racket.height) &&
          (ball.x > racket.x && ball.x < racket.x + racket.width)) {
        // Move the ball differently based on where it hits the racket.
        ball.dx = 8 * ((ball.x - (racket.x + racket.width / 2)) / racket.width);
        ball.dy = -ball.dy;
      } else if (ball.y + ball.dy + ball.height > height) isGameOver = true;
      ball.move();
    }
  }
}