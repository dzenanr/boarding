part of drop;

class Board extends Object with Surface {
  static const int pieceCount = 10;
  static const String drop = 'drop';
  static const String count = 'count';
  static const String hitCount = 'hitCount';

  InputElement pieceCountInput = querySelector('#piece-count');
  LabelElement hitCountLabel = querySelector('#hit-count');

  Board(CanvasElement canvas) {
    this.canvas = canvas;
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
      var x = e.offset.x;
      var y = e.offset.y;
      pieces.forEach((Piece fp) {
        if (fp.contains(x, y)) {
          if (fp.isSelected) {
            fp.isVisible = false;
            var invisibleCount = pieces.invisibleCount();
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
    pieces = new Pieces();
    pieces.create(numberOfPieces);
    pieces.randomInit();
    pieces.forEach((Piece p) {
      p.shape = PieceShape.SQUARE;
      p.width = p.height;
      p.dy = 2;
      p.minMaxSpace.minArea.width = width;
      p.minMaxSpace.minArea.height = height;
      p.minMaxSpace.maxArea.height = height + 200;
    });
    pieceCountInput.value = numberOfPieces.toString();
    hitCountLabel.text = '0';
    isGameOver = false;
  }

  draw() {
    if (!isGameOver) {
      clear();
      pieces.forEach((Piece p) {
        p.move(Direction.DOWN);
        if (p.isVisible) {
          if (p.isSelected) {
            p.shape = PieceShape.ROUNDED_RECT;
          }
          drawPiece(p);
        }
      });
    }
  }

  save() {
    window.localStorage[count] = pieces.length.toString();
    saveBy(drop);
    window.localStorage[hitCount] = pieces.invisibleCount().toString();
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
    loadBy(drop);
    String hitCountString = window.localStorage[hitCount];
    if (hitCountString != null) {
      hitCountLabel.text = hitCountString;
    } else {
      hitCountLabel.text = '0';
    }
  }

  restart() {
    pieces.forEach((Piece fp) {
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
