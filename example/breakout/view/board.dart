part of breakout;

class Board extends Surface {
  num speed = 1, dx = 2, dy = 4;
  Bricks bricks;
  Ball ball;
  Racket racket;
  bool isGameOver;

  Board(CanvasElement canvas): super(canvas) {
    clear();
    querySelector('#play').onClick.listen((e) {
      init();
    });
    SelectElement selectSpeed = querySelector('#speed');
    selectSpeed.value = '1';
    selectSpeed.onChange.listen((Event e) {
      var speed = selectSpeed.value;
      switch (speed) {
        case '1': dx = 2; dy = 4; break;
        case '2': dx = 3; dy = 6; break;
        case '3': dx = 4; dy = 8;
      }
    });
    init();
  }

  init() {
    isGameOver = false;
    bricks = new Bricks(this);
    ball = new Ball(this, 'white', 'yellow');
    racket = new Racket(this, 'white', 'green');
  }

  clear() {
    new Rect(canvas, 0, 0, width, height, color: 'black').draw();
  }

  draw() {
    if (!isGameOver) {
      clear();
      ball.draw();
      racket.draw();
      if (!bricks.draw()) return false; // user wins
      // If hit, reverse the ball.
      if (bricks.wall.contains(ball.x, ball.y)) dy = -dy;
      // Move the racket if left or right is currently pressed.
      if (racket.rightDown) racket.x += 5;
      else if (racket.leftDown) racket.x -= 5;
      if (ball.x + dx + Ball.radius > width ||
          ball.x + dx - Ball.radius < 0) dx = -dx;
      if (ball.y + dy - Ball.radius < 0) dy = -dy;
      else if (ball.y + dy + Ball.radius > height - Racket.height) {
        if (ball.x > racket.x && ball.x < racket.x + Racket.width) {
          // Move the ball differently based on where it hits the racket.
          dx = 8 * ((ball.x- (racket.x + Racket.width / 2)) / Racket.width);
          dy = -dy;
        } else if (ball.y + dy + Ball.radius > height) isGameOver = true;
      }
      ball.x += dx; ball.y += dy;
    }
  }
}