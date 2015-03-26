part of d2048;

class Board extends Surface {
  static const String d2048 = 'd2048';
  static const String d2048Best = 'd2048Best';

  bool isGameOver = false;
  LabelElement bestLabel = querySelector('#best');

  Board(CanvasElement canvas, TileGrid tileGrid) : super(canvas, grid: tileGrid) {
    querySelector('#save').onClick.listen((e) {
      save();
    });
    querySelector('#load').onClick.listen((e) {
      load();
    });
    querySelector('#new').onClick.listen((e) {
      newGame();
    });
    document.onKeyDown.listen((KeyboardEvent event) {
      if (!isGameOver) {
        switch(event.keyCode) {
          case KeyCode.UP:
            tileGrid.cellPieces.move(Direction.UP);
            tileGrid.cellPieces.merge(Direction.UP);
            break;
          case KeyCode.DOWN:
            tileGrid.cellPieces.move(Direction.DOWN);
            tileGrid.cellPieces.merge(Direction.DOWN);
            break;
          case KeyCode.LEFT:
            tileGrid.cellPieces.move(Direction.LEFT);
            tileGrid.cellPieces.merge(Direction.LEFT);
            break;
          case KeyCode.RIGHT:
            tileGrid.cellPieces.move(Direction.RIGHT);
            tileGrid.cellPieces.merge(Direction.RIGHT);
        }
        if (tileGrid.randomAvailableCellPiece() == null) {
          bestLabel.text = saveBest(tileGrid.cellPieces.maxCellPiece().number).toString();
          tileGrid.cellPieces.forEach((CellPiece c) => c.color = 'white');
          isGameOver = true;
        }
      }
    });
    bestLabel.text = loadBest().toString();
    window.animationFrame.then(gameLoop);
  }

  save() => window.localStorage[d2048] = grid.cellPieces.toJsonString();

  num saveBest(num current) {
    var best = loadBest();
    if (current > best) {
      window.localStorage[d2048Best] = current.toString();
      return current;
    }
    return best;
  }

  load() {
    String gameString = window.localStorage[d2048];
    if (gameString != null) {
      grid.cellPieces.empty();
      grid.cellPieces.fromJsonString(gameString);
    }
  }

  num loadBest() {
    var best = window.localStorage[d2048Best];
    if (best != null) {
      return num.parse(best);
    }
    return 0;
  }

  newGame() {
    grid.cellPieces.empty();
    (grid as TileGrid).addTwoRandomAvailableCellPieces();
    isGameOver = false;
  }
}