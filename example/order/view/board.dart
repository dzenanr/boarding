part of order;

class Board extends Object with Surface {
  static const String order = 'order';
  static const String orderScore = 'orderScore';
  static const String orderBest = 'orderBest';

  bool isGameOver = false;
  int score = 0;
  LabelElement scoreLabel = querySelector('#score');
  LabelElement bestLabel = querySelector('#best');

  Board(CanvasElement canvas, TileGrid tileGrid) {
    this.canvas = canvas;
    this.grid = tileGrid;
    querySelector('#save').onClick.listen((e) {
      save();
    });
    querySelector('#load').onClick.listen((e) {
      load();
    });
    querySelector('#new').onClick.listen((e) {
      newGame();
    });
    querySelector('#canvas').onMouseDown.listen((MouseEvent e) {
      int column = (e.offset.x ~/ tileGrid.cellWidth).toInt();
      int row = (e.offset.y ~/ tileGrid.cellHeight).toInt();
      CellPiece cellPiece = tileGrid.cellPieces.cellPiece(column, row);
      if (!isGameOver && !cellPiece.tag.isEmpty && !cellPiece.tag.isMarked) {
        cellPiece.tag.isMarked = true;
        cellPiece.color.main = Tile.markedTileColor;
        if (tileGrid.cellPieces.every((CellPiece cp) => cp.tag.isMarked)) {
          var leftNeighbor =
              tileGrid.cellPieces.neighbor(cellPiece, Direction.LEFT);
          cellPiece.tag.number = leftNeighbor.tag.number + 1;
          if (tileGrid.cellPieces.isCellOrdered()) {
            draw();
            saveScore(score);
            scoreLabel.text = score.toString();
            bestLabel.text = saveBest(score).toString();
          }
          isGameOver = true;
        }
      }
    });
    document.onKeyDown.listen((KeyboardEvent event) {
      if (!isGameOver) {
        switch(event.keyCode) {
          case KeyCode.LEFT:
            tileGrid.cellPieces.move(Direction.LEFT);
            tileGrid.cellPieces.bump(Direction.LEFT);
            break;
          case KeyCode.RIGHT:
            tileGrid.cellPieces.move(Direction.RIGHT);
            tileGrid.cellPieces.bump(Direction.RIGHT);
            break;
          case KeyCode.UP:
            tileGrid.cellPieces.move(Direction.UP);
            tileGrid.cellPieces.bump(Direction.UP);
            break;
          case KeyCode.DOWN:
            tileGrid.cellPieces.move(Direction.DOWN);
            tileGrid.cellPieces.bump(Direction.DOWN);
        }
        if (tileGrid.randomAvailableCellPiece() != null) {
          score++;
        }
      }
    });
    bestLabel.text = loadBest().toString();
  }

  draw() {
    if (!isGameOver) {
      super.draw();
    }
  }

  save() => window.localStorage[order] = grid.cellPieces.toJsonString();

  saveScore(num score) {
    window.localStorage[orderScore] = score.toString();
  }

  num saveBest(num score) {
    var best = loadBest();
    if (score < best) {
      window.localStorage[orderBest] = score.toString();
      return score;
    }
    return best;
  }

  load() {
    var gameString = window.localStorage[order];
    if (gameString != null) {
      grid.cellPieces.empty();
      grid.cellPieces.unmark();
      grid.cellPieces.fromJsonString(gameString);
      score = loadScore();
      isGameOver = false;
    }
  }

  num loadScore() {
    var scoreString = window.localStorage[orderScore];
    if (scoreString != null) {
      return num.parse(scoreString);
    }
    return 0;
  }

  num loadBest() {
    var bestString = window.localStorage[orderBest];
    if (bestString != null) {
      return num.parse(bestString);
    }
    return 999;
  }

  newGame() {
    grid.cellPieces.empty();
    grid.cellPieces.unmark();
    (grid as TileGrid).randomAvailableCellPiece();
    grid.cellPieces.forEach((CellPiece cp) => cp.color.main = Tile.tileColor);
    score = 0;
    isGameOver = false;
  }
}