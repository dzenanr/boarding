part of drop;

class Board extends Surface {
  static const int pieceCount = 10;
  static const String drop = 'drop';
  static const String count = 'count';
  static const String hitCount = 'hitCount';

  MovablePieces fallingPieces;
  bool isGameOver;
  InputElement pieceCountInput = querySelector('#piece-count');
  LabelElement hitCountLabel = querySelector('#hit-count');

  Board(CanvasElement canvas) : super(canvas) {
    init(pieceCount);
    querySelector('#save').onClick.listen((e) {
      save();
    });
    querySelector('#load').onClick.listen((e) {
      load();
    });
    querySelector('#restart').onClick.listen((e) {
      restart();
    });
    querySelector('#start').onClick.listen((e) {
      start();
    });
    canvas.onMouseDown.listen((MouseEvent e) {
      fallingPieces.forEach((MovablePiece fp) {
        var x = e.offset.x;
        var y = e.offset.y;
        if (fp.contains(x, y)) {
          if (fp.isSelected) {
            fp.isVisible = false;
            var invisibleCount = fallingPieces.invisibleCount();
            hitCountLabel.text = invisibleCount.toString();
            if (invisibleCount == pieceCount) {
              isGameOver = true;
            }
          } else {
            fp.isSelected = true;
          }
        }
      });
    });
  }

  init(int numberOfPieces) {
    fallingPieces = new MovablePieces(numberOfPieces);
    fallingPieces.randomInit();
    fallingPieces.forEach((MovablePiece fp) {
      fp.shape = PieceShape.SQUARE;
      fp.width = fp.height;
      fp.dy = 2;
      fp.minMaxSpace.minSize.width = width;
      fp.minMaxSpace.minSize.height = height;
      fp.minMaxSpace.maxSize.height = height + 200;
    });
    pieceCountInput.value = numberOfPieces.toString();
    hitCountLabel.text = '0';
    isGameOver = false;
  }

  draw() {
    if (!isGameOver) {
      clear();
      fallingPieces.forEach((MovablePiece fp) {
        fp.move(Direction.DOWN);
        if (fp.isVisible) {
          if (fp.isSelected) {
            fp.shape = PieceShape.ROUNDED_RECT;
          }
          drawPiece(fp);
        }
      });
    }
  }

  save() {
    window.localStorage[count] = fallingPieces.length.toString();
    window.localStorage[drop] = fallingPieces.toJsonString();
    window.localStorage[hitCount] = fallingPieces.invisibleCount().toString();
  }

  load() {
    String countString = window.localStorage[count];
    if (countString != null) {
      pieceCountInput.value = countString;
      try {
        init(int.parse(countString));
      } on FormatException catch(e) {
        init(pieceCount);
      }
    } else {
      pieceCountInput.value = pieceCount.toString();
    }
    String gameString = window.localStorage[drop];
    if (gameString != null) {
      fallingPieces.fromJsonString(gameString);
    }
    String hitCountString = window.localStorage[hitCount];
    if (hitCountString != null) {
      hitCountLabel.text = hitCountString;
    } else {
      hitCountLabel.text = '0';
    }
  }

  restart() {
    fallingPieces.forEach((MovablePiece fp) {
      fp.isVisible = true;
      fp.isSelected = false;
      fp.shape = PieceShape.SQUARE;
    });
    hitCountLabel.text = '0';
    isGameOver = false;
  }

  start() {
    try {
      init(int.parse(pieceCountInput.value));
    } on FormatException catch(e) {
      init(pieceCount);
    }
  }
}
