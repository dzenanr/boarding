part of dash;

class Board extends Surface {
  static const int pieceCount = 10;
  
  MovablePieces movingRightPieces;
  MovablePieces movingLeftPieces;
  int hitRightCount = 0;
  int hitLeftCount = 0;
  bool isGameOver;
  InputElement pieceCountInput = querySelector('#piece-count');
  LabelElement hitRightCountLabel = querySelector('#hit-right-count');
  LabelElement hitLeftCountLabel = querySelector('#hit-left-count');
  
  Board(CanvasElement canvas) : super(canvas) {
    init(pieceCount);
    querySelector('#start').onClick.listen((e) {
      start();
    });
    window.animationFrame.then(gameLoop);
  }
  
  init(int numberOfPieces) {
    movingRightPieces = new MovablePieces(numberOfPieces);
    movingRightPieces.randomInit();
    movingRightPieces.forEach((MovablePiece mrp) {
      mrp.shape = PieceShape.SQUARE;
      mrp.width = mrp.height;
      mrp.colorCode = 'blue';
      mrp.dx = 2;
      mrp.distanceMaxHeight = height + 200;
    });
    movingLeftPieces = new MovablePieces(numberOfPieces);
    movingLeftPieces.randomInit();
    movingLeftPieces.forEach((MovablePiece mlp) {
      mlp.shape = PieceShape.SQUARE;
      mlp.width = mlp.height;
      mlp.colorCode = 'red';
      mlp.dx = 2;
      mlp.distanceMaxHeight = height + 200;
    });
    pieceCountInput.value = numberOfPieces.toString();
    hitRightCount = 0;
    hitLeftCount = 0;
    hitRightCountLabel.text = '0';
    hitLeftCountLabel.text = '0';
    isGameOver = false;
  }
  
  gameLoop(num delta) {
    if (!isGameOver) {
      draw();
    }
    window.animationFrame.then(gameLoop);
  }
  
  draw() {
    clear();
    movingRightPieces.forEach((MovablePiece mrp) {
      if (mrp.isVisible) {
        mrp.move(Direction.RIGHT);
        drawPiece(mrp);
      }
    });
    movingLeftPieces.forEach((MovablePiece mlp) {
      if (mlp.isVisible) {
        mlp.move(Direction.LEFT);
        drawPiece(mlp);
      }
    });
    movingRightPieces.forEach((MovablePiece mrp) {
      movingLeftPieces.forEach((MovablePiece mlp) {
        if (mrp.isVisible && mlp.isVisible && mrp.hit(mlp)) {
          if (mrp.speed > mlp.speed) {
            hitRightCountLabel.text = (++hitRightCount).toString();
            mlp.isVisible = false;
          } else if (mrp.speed < mlp.speed) {
            hitLeftCountLabel.text = (++hitLeftCount).toString();
            mrp.isVisible = false;
          } else {
            hitRightCountLabel.text = (++hitRightCount).toString();
            hitLeftCountLabel.text = (++hitLeftCount).toString();
            mrp.isVisible = false;
            mlp.isVisible = false;
          }
        }
      });
    });
    if (movingRightPieces.every((Piece p) => !p.isVisible)) {
      isGameOver = true; 
    }
    if (movingLeftPieces.every((Piece p) => !p.isVisible)) {
      isGameOver = true; 
    }
  }
  
  start() {
    try {
      init(int.parse(pieceCountInput.value));
    } on FormatException catch(e) {
      init(pieceCount);
    }
  }
}
