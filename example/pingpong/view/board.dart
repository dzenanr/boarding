part of pingpong;

class Board extends Surface {
  static const num x = 0;
  static const num y = 0;
  static const num ballRadius = 8;
  static const num racketWidth = 75;
  static const num racketHeight = 10; 
  
  num startBallX;
  num startBallY;
  num dx = 2;
  num dy = 4;

  Ball ball;
  Racket northRacket;
  Racket southRacket;

  Board(CanvasElement canvas): super(canvas) {
    clear();
    startBallX = width ~/ 2;
    startBallY = height ~/ 2;
    querySelector('#play').onClick.listen((e) {
      ball = new Ball(this, startBallX, startBallY, ballRadius);
      northRacket = new Racket(this, width/2, y, racketWidth, racketHeight);
      southRacket = new Racket(this, width/2, height - racketHeight, racketWidth, racketHeight);
      window.animationFrame.then(gameLoop);
    });
  }

  gameLoop(num delta) {
    if (draw()) {
      window.animationFrame.then(gameLoop);
    }
  }

  clear() {
    new Rect(this, 0, 0, width, height, color: 'green').draw();
  }

  bool draw() {
    clear();
    ball.draw();
    // Move the north side racket if the left or the right key is pressed.
    if (northRacket.rightDown) {
      if (northRacket.x < width - x - northRacket.w - 4) northRacket.x += 5;
    } else if (northRacket.leftDown) {
      if (northRacket.x > x + 4) northRacket.x -= 5;
    }
    northRacket.draw();  
    // Move the south side racket if the left or the right key is pressed.
    if (southRacket.rightDown) {
      if (southRacket.x < width - x - southRacket.w - 4) southRacket.x += 5;
    } else if (southRacket.leftDown) {
      if (southRacket.x > x + 4) southRacket.x -= 5;
    }
    southRacket.draw();
    // The ball must stay within the west and east sides.
    if (ball.x + dx > width || ball.x + dx < 0) dx = -dx;   
    // The north side.
    if (ball.y + dy < northRacket.h) {
      if (ball.x > northRacket.x && ball.x < northRacket.x + northRacket.w) {
        dy = -dy;
      } else {
        // The ball hits the north side but outside the racket.
        return false;
      }
    }   
    // The south side.
    if (ball.y + dy > height - southRacket.h) {
      if (ball.x > southRacket.x && ball.x < southRacket.x + southRacket.w) {
        dy = -dy;
      } else {
        // The ball hits the south side but outside the racket.
        return false;
      }
    }  
    ball.x += dx;
    ball.y += dy;
    return true;
  }
}