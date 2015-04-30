part of dash;

class Board extends Object with Surface {
  static const int pieceCount = 10;

  Pieces rightPieces;
  Pieces leftPieces;
  int hitRightCount = 0;
  int hitLeftCount = 0;
  InputElement pieceCountInput = querySelector('#piece-count');
  LabelElement hitRightCountLabel = querySelector('#hit-right-count');
  LabelElement hitLeftCountLabel = querySelector('#hit-left-count');

  Board(CanvasElement canvas) {
    this.canvas = canvas;
    init(pieceCount);
    querySelector('#start').onClick.listen((e) {
      start();
    });
  }

  void init(int numberOfPieces) {
    rightPieces = new Pieces();
    rightPieces.create(numberOfPieces);
    rightPieces.randomInit();
    rightPieces.forEach((Piece rp) {
      rp.shape = PieceShape.SQUARE;
      rp.width = rp.height;
      rp.color.main = 'blue';
      rp.dx = 2;
      rp.minMaxSpace.minArea.width = width;
      rp.minMaxSpace.maxArea.width = width + 200;
      rp.minMaxSpace.minArea.height = height;
    });
    leftPieces = new Pieces();
    leftPieces.create(numberOfPieces);
    leftPieces.randomInit();
    leftPieces.forEach((Piece lp) {
      lp.shape = PieceShape.SQUARE;
      lp.width = lp.height;
      lp.color.main = 'red';
      lp.dx = 2;
      lp.minMaxSpace.minArea.width = width;
      lp.minMaxSpace.maxArea.width = width + 200;
      lp.minMaxSpace.minArea.height = height;
    });
    pieceCountInput.value = numberOfPieces.toString();
    hitRightCount = 0;
    hitLeftCount = 0;
    hitRightCountLabel.text = '0';
    hitLeftCountLabel.text = '0';
    isGameOver = false;
  }

  void draw() {
    if (!isGameOver) {
      clear();
      rightPieces.forEach((Piece rp) {
        if (rp.isVisible) {
          rp.move(Direction.RIGHT);
          drawPiece(rp);
        }
      });
      leftPieces.forEach((Piece lp) {
        if (lp.isVisible) {
          lp.move(Direction.LEFT);
          drawPiece(lp);
        }
      });
      rightPieces.forEach((Piece rp) {
        leftPieces.forEach((Piece lp) {
          if (rp.isVisible && lp.isVisible && rp.hit(lp)) {
            if (rp.speed.isMuchFaster(lp.speed) ||
                rp.size.isMuchBigger(lp.size)) {
              hitRightCountLabel.text = (++hitRightCount).toString();
              lp.isVisible = false;
            } else if (lp.speed.isMuchFaster(rp.speed) ||
                       lp.size.isMuchBigger(rp.size)) {
              hitLeftCountLabel.text = (++hitLeftCount).toString();
              rp.isVisible = false;
            } else {
              hitRightCountLabel.text = (++hitRightCount).toString();
              hitLeftCountLabel.text = (++hitLeftCount).toString();
              rp.isVisible = false;
              lp.isVisible = false;
            }
          }
        });
      });
      if (rightPieces.every((Piece p) => !p.isVisible)) {
        isGameOver = true;
      }
      if (leftPieces.every((Piece p) => !p.isVisible)) {
        isGameOver = true;
      }
    }
  }

  void start() {
    try {
      init(int.parse(pieceCountInput.value));
    } on FormatException {
      init(pieceCount);
    }
  }
}
