part of d2048;

class Board extends Object with Surface {
  static const String d2048 = 'd2048';
  static const String d2048Best = 'd2048Best';

  LabelElement bestLabel = querySelector('#best');

  Board(CanvasElement canvas, TileGrid tileGrid) {
    this.canvas = canvas;
    this.grid = tileGrid;
    querySelector('#save').onClick.listen((e) {
      saveBy(d2048);
    });
    querySelector('#load').onClick.listen((e) {
      loadBy(d2048);
    });
    querySelector('#new').onClick.listen((e) {
      newGame();
    });
    document.onKeyDown.listen((KeyboardEvent event) {
      if (!isGameOver) {
        switch(event.keyCode) {
          case KeyCode.LEFT:
            tileGrid.cellPieces.move(Direction.LEFT);
            tileGrid.cellPieces.merge(Direction.LEFT);
            break;
          case KeyCode.RIGHT:
            tileGrid.cellPieces.move(Direction.RIGHT);
            tileGrid.cellPieces.merge(Direction.RIGHT);
            break;
          case KeyCode.UP:
            tileGrid.cellPieces.move(Direction.UP);
            tileGrid.cellPieces.merge(Direction.UP);
            break;
          case KeyCode.DOWN:
            tileGrid.cellPieces.move(Direction.DOWN);
            tileGrid.cellPieces.merge(Direction.DOWN);
        }
        if (tileGrid.randomAvailableCellPiece() == null) {
          bestLabel.text = saveBest(tileGrid.cellPieces.maxCellPiece().tag.number).toString();
          tileGrid.cellPieces.forEach((CellPiece cp) => cp.color.main = Tile.tileColor);
          isGameOver = true;
        }
      }
    });
    bestLabel.text = loadBest().toString();
  }

  num saveBest(num current) {
    var best = loadBest();
    if (current > best) {
      window.localStorage[d2048Best] = current.toString();
      return current;
    }
    return best;
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