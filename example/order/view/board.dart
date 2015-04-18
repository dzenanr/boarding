part of order;

class Board extends Object with Surface {
  bool isGameOver = false;
  int score = 0;
  int level = 1;
  LabelElement scoreLabel = querySelector('#score');
  LabelElement bestLabel = querySelector('#best');
  SelectElement levelSelect = querySelector('#level');

  Board(CanvasElement canvas) {
    this.canvas = canvas;
    levelSelect.onChange.listen((Event e) {
      level = int.parse(levelSelect.value);
    });
    newGame();
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
      int column = (e.offset.x ~/ grid.cellWidth).toInt();
      int row = (e.offset.y ~/ grid.cellHeight).toInt();
      CellPiece cellPiece = grid.cellPieces.cellPiece(column, row);
      if (!isGameOver && !cellPiece.tag.isEmpty) {
        cellPiece.tag.isMarked = !cellPiece.tag.isMarked;
        if (cellPiece.tag.isMarked) {
          cellPiece.color.main = Tile.markedTileColor;
        } else {
          score++;
          cellPiece.color.main = Tile.tileColor;
        }        
        if (grid.cellPieces.every((CellPiece cp) => cp.tag.isMarked)) {
          var leftNeighbor = grid.cellPieces.neighbor(cellPiece, Direction.LEFT);
          cellPiece.tag.number = leftNeighbor.tag.number + 1;
          if (grid.cellPieces.isCellOrdered()) {
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
            grid.cellPieces.move(Direction.LEFT);
            grid.cellPieces.bump(Direction.LEFT);
            break;
          case KeyCode.RIGHT:
            grid.cellPieces.move(Direction.RIGHT);
            grid.cellPieces.bump(Direction.RIGHT);
            break;
          case KeyCode.UP:
            grid.cellPieces.move(Direction.UP);
            grid.cellPieces.bump(Direction.UP);
            break;
          case KeyCode.DOWN:
            grid.cellPieces.move(Direction.DOWN);
            grid.cellPieces.bump(Direction.DOWN);
        }
        if ((grid as TileGrid).randomAvailableCellPiece() != null) {
          score++;
        }
      }
    });
  }

  draw() {
    if (!isGameOver) {
      super.draw();
    }
  }

  save() {
    switch (levelSelect.value) {
      case '1': window.localStorage['order1'] = grid.cellPieces.toJsonString(); break;
      case '2': window.localStorage['order2'] = grid.cellPieces.toJsonString(); break;
      case '3': window.localStorage['order3'] = grid.cellPieces.toJsonString();
    }
  }
  
  saveScore(num score) {
    switch (levelSelect.value) {
      case '1': window.localStorage['order1Score'] = score.toString(); break;
      case '2': window.localStorage['order2Score'] = score.toString(); break;
      case '3': window.localStorage['order3Score'] = score.toString();
    }
    window.localStorage['order1Score'] = score.toString();
  }

  num saveBest(num score) {
    var best = loadBest();
    if (score < best) {
      switch (levelSelect.value) {
        case '1': window.localStorage['order1Best'] = score.toString(); break;
        case '2': window.localStorage['order2Best'] = score.toString(); break;
        case '3': window.localStorage['order3Best'] = score.toString();
      }
      return score;
    }
    return best;
  }

  load() {
    var gameString;
    switch (levelSelect.value) {
      case '1': gameString = window.localStorage['order1']; break;
      case '2': gameString = window.localStorage['order2']; break;
      case '3': gameString = window.localStorage['order3'];
    }
    if (gameString != null) {
      grid.cellPieces.empty();
      grid.cellPieces.unmark();
      grid.cellPieces.fromJsonString(gameString);
      score = loadScore();
      isGameOver = false;
    }
  }

  num loadScore() {
    var scoreString;
    switch (levelSelect.value) {
      case '1': scoreString = window.localStorage['order1Score']; break;
      case '2': scoreString = window.localStorage['order2Score']; break;
      case '3': scoreString = window.localStorage['order3Score'];
    }
    if (scoreString != null) {
      return num.parse(scoreString);
    }
    return 0;
  }

  num loadBest() {
    var bestString;
    switch (levelSelect.value) {
      case '1': bestString = window.localStorage['order1Best']; break;
      case '2': bestString = window.localStorage['order2Best']; break;
      case '3': bestString = window.localStorage['order3Best'];
    }
    if (bestString != null) {
      return num.parse(bestString);
    }
    return 999;
  }

  newGame() {
    var length = level + 2;
    var table = new Table.from(new Size.from(length, length),
                               new Area.from(canvas.width, canvas.height));
    grid = new TileGrid(table);
    score = 0;
    scoreLabel.text = score.toString();
    bestLabel.text = loadBest().toString();
    isGameOver = false;
  }
}